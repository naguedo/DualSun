import { HttpClient, HttpErrorResponse } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { FormArray, FormBuilder, FormGroup, Validators } from '@angular/forms';
import { DomSanitizer } from '@angular/platform-browser';
import 'bootstrap';
import { throwError } from 'rxjs';
import { catchError, finalize } from 'rxjs/operators';

@Component({
  selector: 'app-commissioning-report-form',
  templateUrl: './commissioning-report-form.component.html',
  styleUrls: ['./commissioning-report-form.component.scss'],
})
export class CommissioningReportFormComponent implements OnInit {
  commissioningReportForm: FormGroup;
  panelArray: FormArray;
  submitting = false;
  submitted = false;
  sended = false;
  logoUrl: any;
  error = '';

  options = [
    { id: 'photovoltaic', name: 'Photovoltaic' },
    { id: 'hybrid', name: 'Hybrid' },
  ];

  constructor(
    private http: HttpClient,
    private formBuilder: FormBuilder,
    private sanitizer: DomSanitizer
  ) {
    const now = new Date();
    const nowIsoString = now.toISOString().slice(0, 10);

    this.commissioningReportForm = this.formBuilder.group({
      siren: '',
      phone: '',
      email: '',
      company_name: '',
      name: '',
      street: '',
      city: '',
      zip: '',
      installed_on: nowIsoString,
      option: 'photovoltaic',
      nb_panels: 1,
      panels_attributes: this.formBuilder.array([]),
    });
    this.panelArray = this.commissioningReportForm.get(
      'panels_attributes'
    ) as FormArray;
  }

  ngOnInit(): void {
    this.logoUrl = this.sanitizer.bypassSecurityTrustUrl('assets/logo.png');
    this.syncByNbPanels();
  }

  get f() {
    return this.commissioningReportForm.controls;
  }

  syncByNbPanels() {
    const nbPanels = parseInt(
      this.commissioningReportForm.get('nb_panels')?.value
    );

    if (this.panelArray.length !== nbPanels) {
      while (this.panelArray.length > nbPanels) {
        this.panelArray.removeAt(this.panelArray.length - 1);
      }

      while (this.panelArray.length < nbPanels) {
        const newPanel = this.formBuilder.group({
          identifier: ['', Validators.required],
        });
        this.panelArray.push(newPanel);
      }
    }
  }

  clearForm() {
    this.submitting = false;
    this.submitted = false;
    this.error = '';

    Object.keys(this.commissioningReportForm.controls).forEach((key) => {
      this.commissioningReportForm.get(key)?.setErrors(null);
    });
  }

  onSubmit() {
    // Mainly Server validation
    // if (this.commissioningReportForm.invalid) {
    //   return;
    // }
    this.submitting = true;
    this.submitted = true;

    const url = 'http://localhost:3000/api/v1/commissioning_reports';
    const commissioningReport = { ...this.commissioningReportForm.value };
    delete commissioningReport.nb_panels;
    const data = { commissioning_report: commissioningReport };
    this.http
      .post(url, data)
      .pipe(
        catchError((error: HttpErrorResponse) => {
          this.handleError(error);

          return throwError(
            'An error occurred while sending the commissioning report.'
          );
        })
      )
      .pipe(
        finalize(() => {
          this.submitting = false;
        })
      )
      .subscribe(() => {
        this.commissioningReportForm.reset();
        this.sended = true;
      });
  }

  handleError(error: HttpErrorResponse) {
    const errors = error.error.errors;
    if (error.status === 422) {
      Object.keys(errors).forEach((key) => {
        const mappedKey =
          key === 'panels' || key === 'panels.identifier'
            ? 'panels_attributes'
            : key;
        this.commissioningReportForm
          .get(mappedKey)
          ?.setErrors({ apiError: errors[key] });
      });
    } else {
      this.error = 'Unknown error occured!';
    }
  }
}

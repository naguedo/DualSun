import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpClientModule } from '@angular/common/http';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import {
  NgbDateAdapter,
  NgbDateNativeUTCAdapter,
  NgbModule,
} from '@ng-bootstrap/ng-bootstrap';

import { AppComponent } from './app.component';
import { CommissioningReportFormComponent } from './commissioning-report-form/commissioning-report-form.component';

@NgModule({
  declarations: [
    AppComponent,
    CommissioningReportFormComponent
  ],
  imports: [
    BrowserModule,
    HttpClientModule,
    FormsModule,
    ReactiveFormsModule,
    NgbModule,
  ],
  providers: [{ provide: NgbDateAdapter, useClass: NgbDateNativeUTCAdapter }],
  bootstrap: [AppComponent],
})
export class AppModule {}

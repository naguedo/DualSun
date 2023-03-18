import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CommissioningReportFormComponent } from './commissioning-report-form.component';

describe('CommissioningReportFormComponent', () => {
  let component: CommissioningReportFormComponent;
  let fixture: ComponentFixture<CommissioningReportFormComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ CommissioningReportFormComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(CommissioningReportFormComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

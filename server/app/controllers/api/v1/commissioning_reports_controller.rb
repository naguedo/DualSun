module Api::V1
  class CommissioningReportsController < ApplicationController
    def create
      @commissioning_report = CommissioningReport.new(commissioning_report_params)

      if @commissioning_report.save
        head :no_content
      else
        render json: { errors: @commissioning_report.errors }, status: :unprocessable_entity
      end
    end

    private

    def commissioning_report_params
      params.require(:commissioning_report)
            .permit(:siren, :phone, :email, :company_name, :name, 
                    :street, :city, :zip, :installed_on, 
                    :option, panels_attributes: [:identifier])
    end
  end
end

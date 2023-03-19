require 'test_helper'

module Api::V1
  class CommissioningReportsControllerTest < ActionDispatch::IntegrationTest
    test "should create commissioning report" do
      assert_difference('CommissioningReport.count') do
        post api_v1_commissioning_reports_url, params: { commissioning_report: {
          company_name: "SoleilVert",
          siren: "123456789",
          phone: "0123456789",
          email: "jeandupont@apptest.com",
          name: "Jean Dupont",
          street: "9 Rue de la République",
          city: "Bordeaux",
          zip: 33000,
          installed_on: Date.today,
          option: :photovoltaic,
          panels_attributes: [{ identifier: 123456 }]
        }}, as: :json
      end

      assert_response :success
    end

    test "should not create commissioning report with invalid params" do
      post api_v1_commissioning_reports_url, params: { commissioning_report: {
        siren: "",
        phone: "",
        email: "",
        company_name: "",
        name: "",
        street: "",
        city: "",
        zip: "",
        installed_on: "",
        option: "",
        panels: nil
      }}, as: :json

      assert_response :unprocessable_entity
    end
  end
end

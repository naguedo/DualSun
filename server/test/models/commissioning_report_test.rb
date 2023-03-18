
require 'test_helper'

class CommissioningReportTest < ActiveSupport::TestCase
  setup do
    @commissioning_report = CommissioningReport.new(
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
    )
    @commissioning_report.panels << Panel.new(identifier: 123456)
  end
  test "commissioning report should be valid" do
    assert @commissioning_report.valid?
  end

  test "commissioning report should be invalid without required fields" do
    commissioning_report = CommissioningReport.new()
    assert_not commissioning_report.valid?
    %i(company_name siren phone name email street city zip installed_on option).each do |field|
      assert_equal "This field is required", commissioning_report.errors.messages[field].first, "#{field} can't be blank"
    end
    assert_equal "Must have at least one panel", commissioning_report.errors.messages[:panels].first, 
                                                 "Panels must have at least one panel"
  end

  test "commissioning report should be invalid with an invalid siren" do
    ["000000000", 
     "999999999", 
     "99999999A",
     "12345"].each do |siren|
      @commissioning_report.siren = siren
      assert_not @commissioning_report.valid?
      assert @commissioning_report.errors.messages.include?(:siren)
    end
  end

  test "customer should be invalid with an invalid email" do
    ["customer@dualsun", 
     "customer@", 
     "customer",
     "customer @dualsun.com"].each do |email|
      @commissioning_report.email = email
      assert_not @commissioning_report.valid?
      assert @commissioning_report.errors.messages.include?(:email)
    end
  end

  test "commissioning report should be invalid with an invalid phone" do
    ["063131", 
     "+3363131313131", 
     "01-23-45-6-789",
     "+33 1 23 45 67 890"].each do |phone|
      @commissioning_report.phone = phone
      assert_not @commissioning_report.valid?
      assert @commissioning_report.errors.messages.include?(:phone)
    end
  end

  test "commissioning report should be invalid with an invalid zip" do
    ["1", 
     "12", 
     "123",
     "1234",
     "A1234"].each do |zip|
      @commissioning_report.zip = zip
      assert_not @commissioning_report.valid?
      assert @commissioning_report.errors.messages.include?(:zip)
    end
  end
  
  test "commissioning report should be valid with a valid phone" do
    ["0631313131", 
     "+33631313131", 
     "06 31 31 31 31",
     "+33 6 31 31 31 31"].each do |phone|
      @commissioning_report.phone = phone
      assert @commissioning_report.valid?
    end
  end
end

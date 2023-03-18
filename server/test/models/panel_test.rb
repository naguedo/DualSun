require "test_helper"

class PanelTest < ActiveSupport::TestCase
  setup do
    @commissioning_report = CommissioningReport.create(
      company_name: "SoleilVert",
      siren: "123456789",
      phone: "0123456789",
      email: "jeandupont@apptest.com",
      name: "Jean Dupont",
      street: "9 Rue de la République",
      city: "Bordeaux",
      zip: 33000,
      installed_on: Date.today,
      option: :photovoltaic
    )
  end
  test "panel should be valid" do
    panel = Panel.new(identifier: 123456, commissioning_report: @commissioning_report)
    assert panel.valid?
  end
  test "panel should be invalid identifier format" do
    [1, 12, 123, 1234, 12345].each do |identifier|
      panel = Panel.new(identifier:, commissioning_report: @commissioning_report)
      assert_not panel.valid?
      assert panel.errors.messages.include?(:identifier)
    end
  end
end

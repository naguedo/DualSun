class CreateCommissioningReport < ActiveRecord::Migration[6.1]
  def change
    create_table :commissioning_reports do |t|
      t.string :company_name, null: false
      t.string :siren, null: false
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone, null: false
      t.string :street, null: false
      t.string :city, null: false
      t.integer :zip, limit: 5, null: false
      t.date :installed_on, null: false
      t.integer :option, null: false

      t.timestamps
    end
  end
end

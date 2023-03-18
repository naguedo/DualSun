class CreatePanels < ActiveRecord::Migration[6.1]
  def change
    create_table :panels do |t|
      t.string :identifier
      t.references :commissioning_report, null: false, foreign_key: true

      t.timestamps
    end
  end
end

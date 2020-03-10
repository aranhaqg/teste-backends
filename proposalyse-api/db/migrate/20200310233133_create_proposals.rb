class CreateProposals < ActiveRecord::Migration[5.2]
  def change
    create_table :proposals do |t|
      t.integer :number_of_monthly_installments
      t.decimal :loan_value, precision: 5, scale: 2
      t.references :event, foreign_key: true

      t.timestamps
    end
  end
end

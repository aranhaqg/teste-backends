class CreateProposals < ActiveRecord::Migration[5.2]
  def change
    create_table :proposals do |t|
      t.string :id_hash, null: false
      t.decimal :loan_value, precision: 10, scale: 2, null: false
      t.integer :number_of_monthly_installments, null: false

      t.timestamps
    end
  end
end

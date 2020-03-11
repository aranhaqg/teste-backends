class CreateProponents < ActiveRecord::Migration[5.2]
  def change
    create_table :proponents do |t|
      t.string :id_hash, null: false
      t.string :name, null: false
      t.decimal :monthly_income, precision: 10, scale: 2, null: false
      t.integer :age, null: false
      t.boolean :is_main, null: false
      t.references :proposal, foreign_key: true, null: false

      t.timestamps
    end
  end
end

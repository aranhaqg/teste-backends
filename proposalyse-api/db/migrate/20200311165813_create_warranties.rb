class CreateWarranties < ActiveRecord::Migration[5.2]
  def change
    create_table :warranties do |t|
      t.string :id_hash
      t.decimal :value, precision: 20, scale: 2
      t.string :province
      t.references :proposal, foreign_key: true

      t.timestamps
    end
  end
end

class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :id_hash, null:false
      t.string :schema, null:false
      t.integer :schema_id, null:false
      t.string :action, null:false

      t.timestamps
    end
  end
end

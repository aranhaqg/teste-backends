class CreateEvents < ActiveRecord::Migration[5.2]
  disable_ddl_transaction!

  def change
    create_table :events, id: false do |t|
      t.string :id, null: false
      t.string :schema, null: false
      t.string :action, null: false

      t.timestamps
    end
    add_index :events, :id
  end
end

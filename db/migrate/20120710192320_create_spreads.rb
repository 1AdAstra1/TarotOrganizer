class CreateSpreads < ActiveRecord::Migration
  def change
    create_table :spreads do |t|
      t.integer :client_id
      t.string :name
      t.date :date
      t.string :structure
      t.string :comment
      t.string :feedback

      t.timestamps
    end
  end
end

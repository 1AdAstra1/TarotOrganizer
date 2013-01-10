class CreateInterpretations < ActiveRecord::Migration
  def change
    create_table :interpretations do |t|
      t.string, :text
      t.string :card_code

      t.timestamps
    end
  end
end

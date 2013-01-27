class MakeInterpretationsLong < ActiveRecord::Migration
  def up
    change_column :interpretations, :text, :text, :limit => nil
  end

  def down
  end
end

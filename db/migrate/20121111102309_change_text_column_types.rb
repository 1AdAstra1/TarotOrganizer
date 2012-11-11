class ChangeTextColumnTypes < ActiveRecord::Migration
  def up
    change_column :clients, :comment, :text, :limit => nil
    change_column :spreads, :structure, :text, :limit => nil
    change_column :spreads, :comment, :text, :limit => nil
    change_column :spreads, :feedback, :text, :limit => nil
  end

  def down
  end
end

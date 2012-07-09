class AddStartDate < ActiveRecord::Migration
  def up
    add_column :clients, :start_date, :date
  end

  def down
    remove_column :clients, :start_date
  end
end

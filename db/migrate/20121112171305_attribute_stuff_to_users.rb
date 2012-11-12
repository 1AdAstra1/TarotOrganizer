class AttributeStuffToUsers < ActiveRecord::Migration
  def change
    add_column :clients, :user_id, :integer
    add_column :spreads, :user_id, :integer
  end
end

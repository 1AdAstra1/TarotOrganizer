class SpreadImage < ActiveRecord::Migration
  def up
    add_column :spreads, :image, :string
  end

  def down
    remove_column :spreads, :image
  end
end

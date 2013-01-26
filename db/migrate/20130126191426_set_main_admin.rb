class SetMainAdmin < ActiveRecord::Migration
  def up
    me = User.where(:email => "olga.the.dark@gmail.com").first
    me.role = :admin
    me.save!
  end

  def down
  end
end

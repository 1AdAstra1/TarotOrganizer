#encoding: utf-8
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role
  has_many :clients, :dependent => :destroy
  has_many :spreads, :dependent => :destroy
  after_create :setup_role
  @@roles = {:admin => "Администратор", :paid_user => "Платный аккаунт", :user => "Базовый аккаунт" }
  
  def method_missing(method_name, *args)
    case method_name
     when /^is_(\w+)?/ then
      if(self.role) then self.role == $1 else false end
    else
      raise
    end
  end
  
  def self.all_roles
    @@roles
  end
  
  def setup_role
    self.role = :user
  end
  
end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  has_many :clients, :dependent => :destroy
  has_many :spreads, :dependent => :destroy
  ROLES = %w[admin paid_user user]
  
  def method_missing(method_name, *args)
    case method_name
     when /^is_(\w+)?/ then
      role == $1
    else
      raise
    end
  end
end

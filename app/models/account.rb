class Account < ActiveRecord::Base
  # Include default devise modules. Others available are:
  devise :database_authenticatable, :registerable, :confirmable,
         :omniauthable, :lockable, :timeoutable, :encryptable, :token_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable, :encryptor => :sha512

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
end

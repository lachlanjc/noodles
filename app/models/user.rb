class User < ActiveRecord::Base
  has_many :recipes

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
<<<<<<< HEAD
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
=======
         :recoverable, :rememberable, :trackable, :validatable

>>>>>>> fb29c5cb58435186722a89d78195a90c55772710
  include Gravtastic
  gravtastic
end

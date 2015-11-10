class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :marketable

  has_many :recipes, dependent: :destroy
  has_many :collections, dependent: :destroy
  has_many :visits
end

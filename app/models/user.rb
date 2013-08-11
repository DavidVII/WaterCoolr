class User < ActiveRecord::Base
  has_many :links
  has_many :comments
  has_many :votes

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :username
  validates_uniqueness_of :username, case_sensitive: false
end

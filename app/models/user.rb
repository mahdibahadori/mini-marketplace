class User < ApplicationRecord 
  enum role: [:member, :admin] 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :items, dependent: :destroy
end

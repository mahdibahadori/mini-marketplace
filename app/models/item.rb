class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :picture, dependent: :destroy
  validates :name, presence: true, uniqueness: {case_sensitive: false}  
  
end

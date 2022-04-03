class Post < ApplicationRecord
  has_many_attached :image
  has_many :comments, dependent: :destroy
  has_many :likes
  has_many :angries
  has_many :hearts
  has_many :sads
  has_many :wows
  belongs_to :user

  validates :text, presence: true
  #validates :image, presence: true
  
end

class Post < ApplicationRecord
  has_many_attached :image
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :angries, dependent: :destroy
  has_many :hearts, dependent: :destroy
  has_many :sads, dependent: :destroy
  has_many :wows, dependent: :destroy
  belongs_to :user

  validates :text, presence: true
  #validates :image, presence: true
  
end

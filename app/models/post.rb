class Post < ApplicationRecord
  has_many_attached :image
  has_many :comments
  belongs_to :user
end

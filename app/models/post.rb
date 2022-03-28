class Post < ApplicationRecord
  has_many_attached :image
  has_many :comments, dependent: :destroy
  belongs_to :user
end

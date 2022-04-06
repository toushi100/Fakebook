class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  validates :content, length: { minimum: 1 , message: "cannot be less than 1 character" }
end

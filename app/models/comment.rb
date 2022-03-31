class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :reacts

  validates :content, presence: true
end


class PostCreationValidation < ActiveModel::Validator
  def validate(record)
    if record.text.length < 1  &&  record.image.attached? == false
      record.errors.add :base, "Post must contain text is or an Image to be posted "
    end
  end
end


class Post < ApplicationRecord
  has_many_attached :image
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :angries, dependent: :destroy
  has_many :hearts, dependent: :destroy
  has_many :sads, dependent: :destroy
  has_many :wows, dependent: :destroy
  belongs_to :user
  #validates_with PostCreationValidation
  #validates :text, presence: true
  #validates :image, presence: true

end

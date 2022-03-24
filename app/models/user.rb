class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_picture
  validates :profile_picture, presence: true, blob: { content_type: :image }


  validates_presence_of :user_name
  validates_uniqueness_of :user_name
  validates :user_name, length: { minimum: 5 , message: "cannot be less than 5 characters" }


  validates_presence_of :phone_number
  validates_uniqueness_of :phone_number
  validates :phone_number, numericality: { message: "must be numeric value" }



end

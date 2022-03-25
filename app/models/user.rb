class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_picture
  has_many :friendlists
  has_many :friends, through: :friendlists
  has_many :friend_requests_sent, ->{where(status: false)}, class_name: 'Friendlist'
  has_many :requests_sent, through: :friend_requests_sent, source: :friend



  # Validations 


  validates :profile_picture, presence: true, blob: { content_type: :image }


  validates_presence_of :user_name
  validates :user_name, length: { minimum: 5 , message: "cannot be less than 5 characters" }


  validates_presence_of :phone_number
  validates_uniqueness_of :phone_number
  validates :phone_number, numericality: {message: "must be numeric value" }, length: { is: 7 , message: "must be more than 7 digits" }

end

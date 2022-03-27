class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_picture
  has_many :posts
  has_many :comments
  after_commit :add_default_avatar, on: %i[create update]

  validates_presence_of :user_name
  validates :user_name, length: { minimum: 3 , message: "cannot be less than 3 characters" }
  validates_format_of :user_name, :with => /\A[^0-9`!@#\$%\^&*+_=]+\z/ , message: "is invalid"


  validates_uniqueness_of :phone_number
  validates :phone_number,:presence => true,
                 :numericality => true,
                 :length => { :minimum => 10, :maximum => 15 }


  private
  def add_default_avatar
    unless profile_picture.attached?
      profile_picture.attach(
        io: File.open(
          Rails.root.join(
            'app','assets','images','avatar.png'
          )
        ),
        filename: 'avatar.png',
        content_type: 'image/png'
      )
    end
  end
end

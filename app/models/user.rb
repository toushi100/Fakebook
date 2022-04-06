class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :profile_picture
  # Friendlist Association
  has_many :friendlists
  has_many :friends, through: :friendlists
  has_many :friend_requests_sent, ->{where(status: false)}, class_name: 'Friendlist'
  has_many :requests_sent, through: :friend_requests_sent, source: :friend
  has_many :friend_requests_received, ->{where(status: false)}, class_name: 'Friendlist', foreign_key: 'friend_id'
  has_many :requests_received, through: :friend_requests_received, source: :user
  # Blocklist Association
  has_many :block_lists
  has_many :blocked_friend, through: :block_lists
  #user group
  has_many :user_groups
  has_many :groups, through: :user_groups
  # Post Associations
  has_many :posts, dependent: :destroy
  has_many :comments
  has_many :likes
  has_many :angries
  has_many :hearts
  has_many :sads
  has_many :wows
  
  # Validations 

  after_commit :add_default_avatar
  validates_presence_of :user_name
  validates :user_name, length: { minimum: 2 , message: "cannot be less than 3 characters" }
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

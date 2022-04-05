class Event < ApplicationRecord
    has_and_belongs_to_many :invited, class_name: 'User'

    belongs_to :user
    
    has_many :event_interests, dependent: :destroy
    has_many :interested_users, through: :event_interests, source: :user

    has_many :event_going_users, dependent: :destroy
    has_many :going_users, through: :event_going_users, source: :user

    validates :privacy, inclusion: { in: %w(public friends friends_except only_me), message: "%{value} is not valid" }
end

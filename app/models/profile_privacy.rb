class ProfilePrivacy < ApplicationRecord
    belongs_to :user

    validates :email, inclusion: { in: %w(public friends friends_except only_me), message: "%{value} is not valid" }
    validates :phone_number, inclusion: { in: %w(public friends friends_except only_me), message: "%{value} is not valid" }
    validates :profile_photo, inclusion: { in: %w(public friends friends_except only_me), message: "%{value} is not valid" }
    validates :friends, inclusion: { in: %w(public friends friends_except only_me), message: "%{value} is not valid" }
    validates :groups, inclusion: { in: %w(public friends friends_except only_me), message: "%{value} is not valid" }

end

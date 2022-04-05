class Group < ApplicationRecord
    has_many :user_groups
    has_many :users, through: :user_groups
    validates :name , length: { minimum: 1 , message: "Group name cannot be empty" }
end

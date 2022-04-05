class Event < ApplicationRecord
    has_and_belongs_to_many :invited, class_name: 'User'
end

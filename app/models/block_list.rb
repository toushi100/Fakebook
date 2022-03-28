class BlockList < ApplicationRecord
  belongs_to :user
  belongs_to :blocked_friend, class_name: 'User'
end


# class FrierndlistValidator < ActiveModel::Validator
#   # def validate(record)
#   #   if true
#   #     record.errors.add :base, "This person is evil"
#   #   end
#   # end
# end
class Friendlist < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  # validates_with FrierndlistValidator
end

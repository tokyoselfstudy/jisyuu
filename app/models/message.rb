class Message < ApplicationRecord
  belongs_to :room
  belongs_to :sender, class_name: 'User'
  has_many :messages_receivers
end

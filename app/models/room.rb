class Room < ApplicationRecord
  has_many :entries, dependent: :destroy
  has_many :messages
  belongs_to :event
end

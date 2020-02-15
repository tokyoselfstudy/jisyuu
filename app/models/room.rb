class Room < ApplicationRecord
  has_many :entries, dependent: :destroy
  belongs_to :event
end

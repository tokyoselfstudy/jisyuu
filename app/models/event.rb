class Event < ApplicationRecord
  validates :title, presence: true

  has_one_attached :image
  belongs_to :user
end
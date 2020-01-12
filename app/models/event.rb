class Event < ApplicationRecord
  validates :title, presence: true
  validates :num_of_applicant, presence: true

  has_one_attached :image
  belongs_to :user
end

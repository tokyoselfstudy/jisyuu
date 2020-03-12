# frozen_string_literal: true

class Room < ApplicationRecord
  has_many :entries, dependent: :destroy
  has_many :messages
  belongs_to :event, optional: true

  def event_message?
    self.event_id.present? ? true : false
  end
end

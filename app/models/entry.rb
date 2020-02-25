# frozen_string_literal: true

class Entry < ApplicationRecord
  belongs_to :user
  belongs_to :room
  belongs_to :event

  scope :with_event, -> { joins(:event) }
end

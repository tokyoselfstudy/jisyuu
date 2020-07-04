# frozen_string_literal: true

class EventsUser < ApplicationRecord
  belongs_to :event
  belongs_to :user

  delegate :view_full_name, to: :user
end

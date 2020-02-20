# frozen_string_literal: true

class MessagesReceiver < ApplicationRecord
  belongs_to :message
  belongs_to :receiver, class_name: "User"
end

# frozen_string_literal: true

json.array! @read_count_hash do |key, value|
  json.messageId key
  json.count value
end

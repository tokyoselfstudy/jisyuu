json.array! @messages do |message|
  json.id message.id
  json.sender message&.sender&.nickname.present? ? message&.sender&.nickname : message&.sender&.view_full_name
  json.senderImage url_for(message.sender.avatar.variant(resize: "100x100")) if message&.sender.present? && message.sender.avatar.attached?
  json.body text_url_to_link(h(message.body)).html_safe
end
# frozen_string_literal: true

class Api::MessagesController < ApplicationController
  def index
    @room = Room.find(params[:room_id])
    @messages = @room.messages.includes(:sender).where("id > ?", params[:id])

    updadate_record = MessagesReceiver
    .where(message_id: @room.messages
    .pluck(:id), receiver_id: current_user.id, is_deleted: false, read_status: false)

    updadate_record.update_all(read_status: true) if updadate_record.exists?

    respond_to do |format|
      format.html
      format.json
    end
  end

  def read_count
    @room = Room.find(params[:room_id])
    @read_count_hash = MessagesReceiver
                        .includes(:message)
                        .where(messages: { sender_id: current_user.id })
                        .where(message_id: @room.messages.pluck(:id), read_status: true)
                        .group(:message_id)
                        .count

    respond_to do |format|
      format.html
      format.json
    end
  end
end

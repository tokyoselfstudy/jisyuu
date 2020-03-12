# frozen_string_literal: true

class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_join_room?, only: [:show]

  def index
    entry_rooms_ids = Entry
                        .with_event
                        .where(user_id: current_user.id, is_deleted: false)
                        .where.not(event_id: nil)
                        .order('events.event_date')
                        .pluck(:room_id)

    @event_rooms = Room.eager_load(:event)
                       .where(id: entry_rooms_ids)
                       .order(['field(rooms.id, ?)', entry_rooms_ids])
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages.eager_load(:messages_receivers, :sender)
                              .where(is_deleted: false)
                              .order(:created_at)
    @read_count_hash = MessagesReceiver
                        .where(message_id: @messages.pluck(:id), read_status: true)
                        .group(:message_id)
                        .count
    @new_message = Message.new
    # 現在のユーザーのMessagesReceiverのレコードを更新する
    MessagesReceiver
      .where(message_id: @room.messages
      .pluck(:id), receiver_id: current_user.id, is_deleted: false, read_status: false)
      .update_all(read_status: true)
    render layout: 'message'
  end

  private
    def is_join_room?
      room = Room.find(params[:id])
      is_join_room = room.entries.where(user_id: current_user.id, is_deleted: false).exists?
      return redirect_to rooms_path, alert: "不正な操作が行われました。" unless is_join_room
    end
end

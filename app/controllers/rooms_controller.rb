class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_join_room?, only: [:show]

  def index
    entry_rooms_ids = Entry.where(user_id: current_user.id, is_deleted: false).where.not(event_id: nil).pluck(:room_id)
    @event_rooms = Room.eager_load(:event).where(id: entry_rooms_ids)
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages.where(is_deleted: false).order(:created_at)
    @new_message = Message.new
  end

  private
    def is_join_room?
      room = Room.find(params[:id])
      is_join_room = room.entries.where(user_id: current_user.id, is_deleted: false).exists?
      return redirect_to rooms_path, alert: '不正な操作が行われました。' unless is_join_room
    end
end

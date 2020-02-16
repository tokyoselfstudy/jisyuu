class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    entry_rooms_ids = Entry.where(user_id: current_user.id, is_deleted: false).where.not(event_id: nil).pluck(:room_id)
    @event_rooms = Room.eager_load(:event).where(id: entry_rooms_ids)
  end

  def show
    @room = Room.find(params[:id])
    @messages = @room.messages.where(is_deleted: false).order(:created_at)
  end
end

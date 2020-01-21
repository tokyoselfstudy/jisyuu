class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @upcoming_events = Event.upcoming_events(current_user.id)
    @past_events = Event.past_events(current_user.id)
  end

  def events
    @future_events = Event.where(user_id: params[:id], is_deleted: false).where('event_date > ?', Time.zone.now)
    @past_events = Event.where(user_id: params[:id], is_deleted: false).where('event_date < ?', Time.zone.now)
  end
end

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @upcoming_events = Event.upcoming_events(current_user.id)
    @past_events = Event.past_events(current_user.id)
  end
end

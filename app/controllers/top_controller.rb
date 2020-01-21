class TopController < ApplicationController
  before_action :authenticate_user!, only: [:menu, :manager_menu]

  def index
  end

  def menu
    
  end

  def manager_menu
    @event = Event.find(params[:event_id])
  end
end

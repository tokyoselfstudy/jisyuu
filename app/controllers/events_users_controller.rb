# frozen_string_literal: true

class EventsUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :within_event_capacity?, only: :create

  def create
    events_user = current_user.events_users.build(events_users_params)
    if events_user.save
      flash[:notice] = "参加登録が完了しました。"
      redirect_to event_path(@event.id)
    else
      flash[:alert] = "参加登録に失敗しました。"
      render event_path(@event.id)
    end
  end

  def destroy
    events_user = EventsUser.find(events_cancel_params[:id])
    @event = Event.find(events_user.event_id)
    if events_user.destroy
      flash[:notice] = "参加登録をキャンセルしました。"
      redirect_to event_path(@event.id)
    else
      flash[:alert] = "参加登録のキャンセルに失敗しました。"
      render event_path(@event.id)
    end
  end

  private
    def events_users_params
      params.permit(:event_id)
    end

    def events_cancel_params
      params.permit(:id)
    end

    def within_event_capacity?
      @event = Event.find(params[:event_id])
      participate_count = EventsUser.where(event_id: @event.id).count
      if @event.num_of_applicant <= participate_count
        flash[:alert] = "定員に達しています"
        redirect_to event_path(@event.id)
      end
    end
end

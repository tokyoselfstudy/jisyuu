# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :is_manager?, only: [:new, :create, :edit, :update, :destroy]
  before_action :create_event_date_params, only: [:create, :update]
  before_action :create_event_end_date_params, only: [:create, :update]

  def new
    @event = current_user.event.build
  end

  def show
    @event = Event.find(params[:id])
    @events_user = EventsUser.where(event_id: @event.id, user_id: current_user.id).first if user_signed_in?
  end

  def create
    @event = current_user.event.build(event_params)
    @event.event_date = create_event_date_params
    @event.event_end_date = create_event_end_date_params

    if @event.save
      flash[:notice] = "イベントを作成しました。"
      redirect_to event_path(@event.id)
    else
      flash[:alert] = "イベントの作成に失敗しました。"
      render :new
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(event_params)
      flash[:notice] = "イベントの更新に成功しました。"
      redirect_to event_path(@event.id)
    else
      flash[:alert] = "イベントの更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    if @event.destroy
      flash[:notice] = "イベントの削除に成功しました。"
      redirect_to events_user_path(current_user)
    else
      @future_events = Event.where(user_id: current_user.id, is_deleted: false).where("event_date > ?", Time.zone.now)
      @past_events = Event.where(user_id: current_user.id, is_deleted: false).where("event_date < ?", Time.zone.now)
      flash[:alert] = "イベントの削除に失敗しました。"
      redirect_to events_user_path(current_user)
    end
  end

  private
    def event_params
      params.require(:event).permit(:title, :detail, :event_date, :event_end_date, :place_name, :place_address, :place_url, :num_of_applicant, :reason, :target, :fee, :image)
    end

    def create_event_date_params
      date = params[:event]
      Time.zone.local(date["event_date(1i)"].to_i, date["event_date(2i)"].to_i, date["event_date(3i)"].to_i, date["event_date(4i)"].to_i, date["event_date(5i)"].to_i)
    end

    def create_event_end_date_params
      date = params[:event]
      Time.zone.local(date["event_end_date(1i)"].to_i, date["event_end_date(2i)"].to_i, date["event_end_date(3i)"].to_i, date["event_end_date(4i)"].to_i, date["event_end_date(5i)"].to_i)
    end
end

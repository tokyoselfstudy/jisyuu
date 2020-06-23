# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @upcoming_events = Event.upcoming_events(@user.id)
    @past_events = Event.past_events(@user.id)
  end

  def events
    @future_events = Event.where(user_id: params[:id], is_deleted: false).where("event_date > ?", Time.zone.now)
    @past_events = Event.where(user_id: params[:id], is_deleted: false).where("event_date < ?", Time.zone.now)
  end

  def my_records
    @learn_records = LearnRecord.user_learn_records(current_user.id).order(created_at: :desc)
    render "learn_records/index"
  end

  def copy_events
    @events = Event
                .where(user_id: params[:id], is_deleted: false)
                .order(event_date: :desc)
                .limit(40)
                .page(params[:page])
                .per(10)
  end
end

# frozen_string_literal: true

class EventsUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :within_event_capacity?, only: :create

  def create
    @event = Event.find(events_users_params[:event_id])
    events_user = current_user.events_users.build(events_users_params)
    room = Room.find_by(event_id: @event.id)
    begin
      ActiveRecord::Base.transaction do
        # イベントの参加と同時にEntryテーブル（メッセの参加を制御するテーブル）にもレコードを入れる。
        events_user.save!
        room.entries.create!(
          user_id: current_user.id,
          event_id: @event.id,
        )
      end
    rescue => e
      logger.error "イベント参加エラー: #{e}"
      flash[:alert] = "参加登録に失敗しました。"
      return render event_path(@event.id)
    end
    flash[:notice] = "参加登録が完了しました。"
    redirect_to event_path(@event.id)
  end

  def destroy
    events_user = EventsUser.find(events_cancel_params[:id])
    @event = Event.find(events_user.event_id)
    entry = Entry.find_by(event_id: @event.id, user_id: current_user.id)
    begin
      ActiveRecord::Base.transaction do
        # イベントの参加キャンセルと同時にEntryテーブル（メッセの参加を制御するテーブル）のレコードも物理削除。
        events_user.destroy!
        entry.destroy!
      end
    rescue => e
      logger.error "イベント参加キャンセルエラー: #{e}"
      flash[:alert] = "参加登録のキャンセルに失敗しました。"
      render event_path(@event.id)
    end
    flash[:notice] = "参加登録をキャンセルしました。"
    redirect_to event_path(@event.id)
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

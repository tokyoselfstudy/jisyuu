# frozen_string_literal: true

class Admin::EventsUsersController < Admin::Base
  def destroy
    events_user = EventsUser.find(params[:id])
    entry = Entry.find_by(event_id: events_user.event_id, user_id: params[:user_id])
    begin
      ActiveRecord::Base.transaction do
        # イベントの参加キャンセルと同時にEntryテーブル（メッセの参加を制御するテーブル）のレコードも物理削除。
        events_user.destroy!
        entry.destroy!
      end
    rescue => e
      logger.error "管理者イベント参加者削除エラー: #{e}"
      flash.now[:alert] = "イベント参加者から#{events_user.view_full_name}さんの削除に失敗しました。"
      render event_path(events_user.event_id)
    end
    flash[:notice] = "イベント参加者から#{events_user.view_full_name}さんの削除に成功しました。"
    redirect_to event_path(events_user.event_id)
  end
end

# frozen_string_literal: true

require "rails_helper"

RSpec.describe "管理者によるイベント参加者管理", type: :request do
  describe "イベント参加者削除" do
    let(:user) { create(:user) }
    let(:admin_user) { create(:admin_user) }
    let(:event) { create(:event, user: admin_user) }

    before do
      sign_in user
      post events_users_path(event_id: event.id),
        params: { event_id: event.id }
      @events_user = event.events_users.last
    end

    it "管理者ならイベント参加者を削除できる" do
      sign_in admin_user

      expect {
        delete admin_user_events_user_path(user, @events_user.id),
          params: { user_id: user.id, id: @events_user.id }
      }.to change(event.events_users, :count).by(-1)
    end
  end
end

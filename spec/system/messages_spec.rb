# frozen_string_literal: true

require "rails_helper"

RSpec.describe "イベント参加者のメッセージ機能", type: :system do
  describe "メッセージ送信" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:manager_user) { FactoryBot.create(:manager_user) }
    let!(:event) { FactoryBot.create(:event, user: manager_user) }

    before do
      visit new_user_session_path
      fill_in "メールアドレス", with: login_user.email
      fill_in "パスワード", with: login_user.password
      click_button "ログイン"
      visit event_path(event)
      find(".event-apply-btn").click
      expect(page).to have_selector ".alert-success", text: "参加登録が完了しました。"
    end

    context "イベント参加ユーザーがイベントメッセージルームからメッセージを送信する" do
      let(:login_user) { user }
      it "メッセージ送信" do
        visit room_path(event.room)
        fill_in "textarea", with: "test-message"
        find(".message-btn").click
        expect(event.room.messages.first.body).to eq("test-message")
      end
    end
  end
end

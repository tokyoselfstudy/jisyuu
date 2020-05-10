# frozen_string_literal: true

require "rails_helper"

RSpec.describe "イベント参加機能", type: :system do
  describe "イベントへの参加" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:incomplete_user) { FactoryBot.create(:user, family_name: "") }
    let!(:manager_user) { FactoryBot.create(:manager_user) }
    let!(:event) { FactoryBot.create(:event, user: manager_user) }

    before do
      visit new_user_session_path
      fill_in "メールアドレス", with: login_user.email
      fill_in "パスワード", with: login_user.password
      click_button "ログイン"
    end

    context "登録情報が完全なログインユーザー" do
      let(:login_user) { user }
      it "イベント参加に成功する" do
        visit event_path(event)
        find(".event-apply-btn").click
        expect(page).to have_selector ".alert-success", text: "参加登録が完了しました。"
      end
    end

    context "登録情報が不完全なログインユーザー" do
      let(:login_user) { incomplete_user }
      it "イベント参加に失敗する" do
        visit event_path(event)
        find(".event-apply-btn").click
        expect(page).to have_selector ".alert-danger", text: "イベントに参加するためには必須情報をご入力ください"
      end
    end
  end
end

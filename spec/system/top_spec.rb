# frozen_string_literal: true

require "rails_helper"

RSpec.describe "トップページ", type: :system do
  let!(:user) { FactoryBot.create(:user) }

  before do
    visit new_user_session_path
    fill_in "メールアドレス", with: login_user.email
    fill_in "パスワード", with: login_user.password
    click_button "ログイン"
  end

  context "カルーセル" do
    let(:login_user) { user }
    it "カルーセルが正しい内容を表示すること" do
      visit root_path
      expect(page).to have_selector("img[src$='/jisyuu-top1.png']")
      expect(page.find_link(href: 'https://www.tokyoselfstudy.com/blogs/620', visible: false)).to have_selector("img[src$='/jisyuu-top2.png?20210918']", visible: false)
      expect(page.find_link(href: 'https://www.tokyoselfstudy.com/blogs/20', visible: false)).to have_selector("img[src$='/jisyuu-top3.png']", visible: false)
      expect(page.find_link(href: 'https://www.tokyoselfstudy.com/blogs/248', visible: false)).to have_selector("img[src$='/jisyuu-top4.png']", visible: false)
    end
  end
end

# frozen_string_literal: true

require "rails_helper"

RSpec.describe "ユーザー詳細ページ", type: :system do
  let!(:user) { FactoryBot.create(:user) }

  before do
    visit new_user_session_path
    fill_in "メールアドレス", with: login_user.email
    fill_in "パスワード", with: login_user.password
    click_button "ログイン"
  end

  context "snsアカウント" do
    let(:login_user) { user }
    it "twitter/instagramがnilの場合、snsアイコンは非表示" do
      user.update(twitter: nil, instagram: nil)
      visit user_path(user)
      
      aggregate_failures do
        expect(page.find('div.sns-area')).not_to have_link href: 'https://twitter.com/'
        expect(page.find('div.sns-area')).not_to have_link href: 'https://instagram.com/'
      end
      # expect(page).to have_selector("img[src$='/jisyuu-top1.png']")
      # expect(page.find_link(href: 'https://www.tokyoselfstudy.com/blogs/620', visible: false)).to have_selector("img[src$='/jisyuu-top2.png?20210918']", visible: false)
      # expect(page.find_link(href: 'https://www.tokyoselfstudy.com/blogs/20', visible: false)).to have_selector("img[src$='/jisyuu-top3.png']", visible: false)
      # expect(page.find_link(href: 'https://www.tokyoselfstudy.com/blogs/248', visible: false)).to have_selector("img[src$='/jisyuu-top4.png']", visible: false)
    end

     it "twitter/instagramがブランクの場合、snsアイコンは非表示" do
      user.update(twitter: '', instagram: '')
      visit user_path(user)

      aggregate_failures do
        expect(page.find('div.sns-area')).not_to have_link href: 'https://twitter.com/'
        expect(page.find('div.sns-area')).not_to have_link href: 'https://instagram.com/'
      end
     end

     it "twitterが設定されている場合、twitterアイコンは表示（instagramは非表示）" do
      user.update(twitter: 'aaaa', instagram: '')
      visit user_path(user)

      aggregate_failures do
        twitter_link = page.find('div.sns-area').find_link(href: 'https://twitter.com/aaaa')
        expect(twitter_link).to have_selector("svg.fa-twitter")
        expect(page.find('div.sns-area')).not_to have_link href: 'https://instagram.com/'
      end
     end

     it "instagramが設定されている場合、instagramアイコンは表示（twitterは非表示）" do
      user.update(twitter: '', instagram: 'bbbb')
      visit user_path(user)

      aggregate_failures do
        instagram_link = page.find('div.sns-area').find_link(href: 'https://instagram.com/bbbb')
        expect(instagram_link).to have_selector("svg.fa-instagram")
        expect(page.find('div.sns-area')).not_to have_link href: 'https://twitter.com/'
      end
     end

     it "instagram,twitterが設定されている場合、twitter, instagramアイコンは表示" do
      user.update(twitter: 'aaaa', instagram: 'bbbb')
      visit user_path(user)

      aggregate_failures do
        twitter_link = page.find('div.sns-area').find_link(href: 'https://twitter.com/aaaa')
        expect(twitter_link).to have_selector("svg.fa-twitter")
        instagram_link = page.find('div.sns-area').find_link(href: 'https://instagram.com/bbbb')
        expect(instagram_link).to have_selector("svg.fa-instagram")
      end
     end
  end
end

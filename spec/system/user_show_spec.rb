# frozen_string_literal: true

require "rails_helper"

RSpec.describe "ユーザー詳細ページ", type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:other_user) { FactoryBot.create(:user) }

  def login_action
    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"
  end

  context "snsアカウント" do

    RSpec.shared_examples 'show sns icons' do
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

    context "ログイン前も表示される" do
      it_behaves_like 'show sns icons'
    end

    context "ログイン後" do
      before do
        login_action
      end
  
      it "twitter/instagramがnilの場合、snsアイコンは非表示" do
        user.update(twitter: nil, instagram: nil)
        visit user_path(user)
        
        aggregate_failures do
          expect(page.find('div.sns-area')).not_to have_link href: 'https://twitter.com/'
          expect(page.find('div.sns-area')).not_to have_link href: 'https://instagram.com/'
        end
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
  
      it_behaves_like 'show sns icons'

    end
  end

  context "プロフィールを編集するボタン" do
    context "ログイン前" do
      it "ボタンは非表示" do
        visit user_path(user)
        expect(page.find('div.profile-block')).not_to have_link href: '/users/edit'
      end
    end

    context "ログイン後" do
      before do
        login_action
      end

      it "自分のプロフィール上には表示" do
        visit user_path(user)
        expect(page.find('div.profile-block')).to have_link href: '/users/edit'
      end

      it "他人のプロフィール上には非表示" do
        visit user_path(other_user)
        expect(page.find('div.profile-block')).not_to have_link href: '/users/edit'
      end
    end
  end
end

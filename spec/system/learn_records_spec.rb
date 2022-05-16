# frozen_string_literal: true

require "rails_helper"

RSpec.describe "learn_records", type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:user_learn_record) { FactoryBot.create(:learn_record, user: user) }

  let!(:other_user) { FactoryBot.create(:user) }
  let!(:manager_user) { FactoryBot.create(:manager_user) }
  let!(:admin_user) { FactoryBot.create(:admin_user) }
  
  describe "showページ" do
    shared_examples 'show edit and delete links and they work correctly' do
      it "編集リンクが表示され、クリックで編集画面に遷移する" do
        expect(page.find('div.edit-links')).to have_link '編集', href: edit_learn_record_path(user_learn_record)
        click_link '編集'
        expect(current_path).to eq edit_learn_record_path(user_learn_record)
      end

      it "削除リンクが表示され、クリックで削除できる" do
        expect(page.find('div.edit-links')).to have_link '削除', href: learn_record_path(user_learn_record, action: :delete)
        page.accept_confirm do
          click_link '削除'
        end
        aggregate_failures do
          expect(current_path).to eq learn_records_path
          expect(page).to have_selector('.alert-success', text: 'ブログの削除に成功しました。')
          expect(user_learn_record.reload.is_deleted).to eq true
        end
      end
    end

    shared_examples "don't show edit and delete links" do
      it "編集リンクが表示されない" do
        expect(page).not_to have_link '編集', href: edit_learn_record_path(user_learn_record)
      end

      it "削除リンクが表示されない" do
        expect(page).not_to have_link '削除', href: learn_record_path(user_learn_record, action: :delete)
      end
    end

    context "自分で作ったブログ" do
      before do
        visit new_user_session_path
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: user.password
        click_button "ログイン"

        visit learn_record_path(user_learn_record)
      end

      it_behaves_like 'show edit and delete links and they work correctly'

    end

    context "他人が作ったブログ（一般ユーザー）" do
      before do
        visit new_user_session_path
        fill_in "メールアドレス", with: other_user.email
        fill_in "パスワード", with: other_user.password
        click_button "ログイン"

        visit learn_record_path(user_learn_record)
      end

      it_behaves_like "don't show edit and delete links"
    end

    context "他人が作ったブログ（マネージャー）" do
      before do
        visit new_user_session_path
        fill_in "メールアドレス", with: manager_user.email
        fill_in "パスワード", with: manager_user.password
        click_button "ログイン"

        visit learn_record_path(user_learn_record)
      end

      it_behaves_like "don't show edit and delete links"
    end

    context "他人が作ったブログ（管理ユーザー）" do
      before do
        visit new_user_session_path
        fill_in "メールアドレス", with: admin_user.email
        fill_in "パスワード", with: admin_user.password
        click_button "ログイン"

        visit learn_record_path(user_learn_record)
      end

      it_behaves_like 'show edit and delete links and they work correctly'
    end
  end

  shared_examples 'redirect to root and show alert' do
    it "ルートページにリダイレクトされ、アラートメッセージを表示する" do
      expect(current_path).to eq root_path
      expect(page).to have_selector('.alert-danger', text: 'ブログの変更・削除権限がありません。')
    end
  end

  describe "editページ" do
    shared_examples 'show edit page and can save editted content' do
      it "タイトルを編集して更新できる" do
        fill_in 'learn_record[title]', with: '更新後のタイトル'
        click_button '登録する'
        aggregate_failures do
          expect(current_path).to eq learn_record_path(user_learn_record)
          expect(user_learn_record.reload.title).to eq '更新後のタイトル'
        end
      end
    end

    context "自分で作ったブログ" do
      before do
        visit new_user_session_path
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: user.password
        click_button "ログイン"

        visit edit_learn_record_path(user_learn_record)
      end

      it_behaves_like 'show edit page and can save editted content'
    end

    context "他人が作ったブログ" do
      before do
        visit new_user_session_path
        fill_in "メールアドレス", with: other_user.email
        fill_in "パスワード", with: other_user.password
        click_button "ログイン"

        visit edit_learn_record_path(user_learn_record)
      end

      it_behaves_like 'redirect to root and show alert'
    end

    context "他人が作ったブログ（マネージャー）" do
      before do
        visit new_user_session_path
        fill_in "メールアドレス", with: manager_user.email
        fill_in "パスワード", with: manager_user.password
        click_button "ログイン"

        visit edit_learn_record_path(user_learn_record)
      end

      it_behaves_like 'redirect to root and show alert'
    end

    context "他人が作ったブログ（管理人）" do
      before do
        visit new_user_session_path
        fill_in "メールアドレス", with: admin_user.email
        fill_in "パスワード", with: admin_user.password
        click_button "ログイン"

        visit edit_learn_record_path(user_learn_record)
      end

      it_behaves_like 'show edit page and can save editted content'
    end
  end

  describe "menuページ" do
    shared_examples 'show edit and delete links and they work correctly' do
      it "編集リンクが表示され、クリックで編集画面に遷移する" do
        expect(page).to have_link 'ブログ編集', href: edit_learn_record_path(user_learn_record)
        click_link 'ブログ編集'
        expect(current_path).to eq edit_learn_record_path(user_learn_record)
      end

      it "削除リンクが表示され、クリックで削除できる" do
        expect(page).to have_link 'ブログ削除', href: learn_record_path(user_learn_record, action: :delete)
        page.accept_confirm do
          click_link 'ブログ削除'
        end

        aggregate_failures do
          expect(current_path).to eq learn_records_path
          expect(page).to have_selector('.alert-success', text: 'ブログの削除に成功しました。')
          expect(user_learn_record.reload.is_deleted).to eq true
        end
      end
    end

    context "自分で作ったブログ" do
      before do
        visit new_user_session_path
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: user.password
        click_button "ログイン"

        visit menu_learn_record_path(user_learn_record)
      end

      it_behaves_like 'show edit and delete links and they work correctly'
    end

    context "他人が作ったブログ（一般ユーザー）" do
      before do
        visit new_user_session_path
        fill_in "メールアドレス", with: other_user.email
        fill_in "パスワード", with: other_user.password
        click_button "ログイン"

        visit menu_learn_record_path(user_learn_record)
      end

      it_behaves_like 'redirect to root and show alert'
    end

    context "他人が作ったブログ（マネージャー）" do
      before do
        visit new_user_session_path
        fill_in "メールアドレス", with: manager_user.email
        fill_in "パスワード", with: manager_user.password
        click_button "ログイン"

        visit menu_learn_record_path(user_learn_record)
      end

      it_behaves_like 'redirect to root and show alert'
    end

    context "他人が作ったブログ（管理ユーザー）" do
      before do
        visit new_user_session_path
        fill_in "メールアドレス", with: admin_user.email
        fill_in "パスワード", with: admin_user.password
        click_button "ログイン"

        visit menu_learn_record_path(user_learn_record)
      end

      it_behaves_like 'show edit and delete links and they work correctly'
    end
  end
end

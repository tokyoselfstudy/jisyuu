# frozen_string_literal: true

require "rails_helper"

RSpec.describe "ユーザーアカウント新規登録", type: :request do
  describe "新規登録" do
    let(:new_registration_user_params) { attributes_for(:new_registration_confirmed_user) }

    context "成功する" do
      it "全ての必須項目（メールアドレス・パスワード）を埋めていれば新規登録できる" do
        new_registration_user_params.merge!(confirmed_at: '')
        expect {
          post user_registration_path,
            params: { user: new_registration_user_params }
        }.to change(User, :count).by(1)
      end
    end

    context "失敗する" do
      it "全ての必須項目が埋まっていない状態であれば新規登録できない" do
        new_registration_user_params.merge!(email: '', confirmed_at: '')
        expect {
          post user_registration_path,
            params: { user: new_registration_user_params }
        }.not_to change(User, :count)
      end
    end
  end
end

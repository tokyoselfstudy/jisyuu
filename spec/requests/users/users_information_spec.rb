# frozen_string_literal: true

require "rails_helper"

RSpec.describe "ユーザー自身による情報管理", type: :request do
  describe "更新" do
    let(:new_registration_confirmed_user) { create(:new_registration_confirmed_user) }
    let(:params_hash) { attributes_for(:user) }

    context 'ログインしている場合' do
      before do
        new_registration_confirmed_user.confirm
        sign_in new_registration_confirmed_user
      end
      it "全ての必須項目を埋めて更新" do
        attribute = { "birthdate(1i)" => "1989", "birthdate(2i)" => "12", "birthdate(3i)" => "10" }
        params_hash.merge!(attribute)
        p params_hash
        put user_registration_path(new_registration_confirmed_user), params: { user: params_hash }
        new_registration_confirmed_user.reload
        expect(new_registration_confirmed_user.family_name).to eq("田中")
      end
    end
  end
end

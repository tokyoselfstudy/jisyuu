# frozen_string_literal: true

require "rails_helper"

RSpec.describe "ユーザーアカウント管理", type: :request do
  describe "更新" do
    let(:new_registration_confirmed_user) { create(:new_registration_confirmed_user) }
    let(:params_hash) { attributes_for(:user) }

    context "ログインしている場合" do
      before do
        sign_in new_registration_confirmed_user
      end
      it "全ての必須項目を埋めていれば更新できる" do
        birthdate_attribute = { "birthdate(1i)" => "1989", "birthdate(2i)" => "12", "birthdate(3i)" => "10" }
        params_hash.merge!(birthdate_attribute)
        patch user_registration_path,
          params: { user: params_hash }
        new_registration_confirmed_user.reload
        expect(new_registration_confirmed_user.family_name).to eq("田中")
      end

      it "全ての必須項目が埋まっていない状態であれば更新できない" do
        birthdate_attribute = { "birthdate(1i)" => "1989", "birthdate(2i)" => "12", "birthdate(3i)" => "10" }
        params_hash.merge!(birthdate_attribute)
        params_hash.except(:family_name)
        expect {
          patch user_registration_path,
            params: { user: params_hash }
        }.not_to change { new_registration_confirmed_user }
      end
    end
  end
end

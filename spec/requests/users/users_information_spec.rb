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

      it "twitter, instagramの情報を入れて更新できる" do
        birthdate_attribute = { "birthdate(1i)" => "1989", "birthdate(2i)" => "12", "birthdate(3i)" => "10" }
        sns_attribute = { "twitter" => "aaa", "instagram" => "bbb" }
        params_hash.merge!(birthdate_attribute).merge!(sns_attribute)
        patch user_registration_path,
          params: { user: params_hash }
        new_registration_confirmed_user.reload
        aggregate_failures do
          expect(new_registration_confirmed_user.twitter).to eq("aaa")
          expect(new_registration_confirmed_user.instagram).to eq("bbb")
        end
      end

      it "twitterが不正な値の場合、更新できない" do
        birthdate_attribute = { "birthdate(1i)" => "1989", "birthdate(2i)" => "12", "birthdate(3i)" => "10" }
        twitter_attribute = { "twitter" => "あああ" }
        params_hash.merge!(birthdate_attribute).merge!(twitter_attribute)
        expect {
          patch user_registration_path,
            params: { user: params_hash }
        }.not_to change { new_registration_confirmed_user }
      end
      
      it "instagramが不正な値の場合、更新できない" do
        birthdate_attribute = { "birthdate(1i)" => "1989", "birthdate(2i)" => "12", "birthdate(3i)" => "10" }
        twitter_attribute = { "instagram" => "いいい" }
        params_hash.merge!(birthdate_attribute).merge!(twitter_attribute)
        expect {
          patch user_registration_path,
            params: { user: params_hash }
        }.not_to change { new_registration_confirmed_user }
      end
    end
  end
end

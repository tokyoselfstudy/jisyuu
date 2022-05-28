require 'rails_helper'

RSpec.describe User, type: :model do
  describe "twitter, instagramのバリデーションチェック" do
    let(:user) { FactoryBot.create(:user) }
    subject { user.valid? }

    context "twitter" do
      it "nilは有効" do
        user.twitter = nil
        is_expected.to eq true
      end

      it "空文字は有効" do
        user.twitter = ''
        is_expected.to eq true
      end

      it "15文字以内の[a-zA-Z_0-9]は有効" do
        valid_twitters = [
          "abc_DEF_123",      # 全パターンの文字列を含む
          "a",                # 最小長：1文字
          "123456789012345",  # 最大長：15文字
        ]

        aggregate_failures do
          valid_twitters.each do |valid_twitter|
            user.twitter = valid_twitter
            expect(user.valid?).to eq true 
          end
        end
      end

      it "15文字以内の[a-zA-Z_0-9]に該当しない場合は無効" do
        valid_twitters = [
          "abc_DEF_123#",     # 不正な文字を含む（記号）
          "abc_DEF_123あ",    # 不正な文字を含む（全角文字列）
          "1234567890123456", # 最大長：15文字を超える
        ]

        aggregate_failures do
          valid_twitters.each do |valid_twitter|
            user.twitter = valid_twitter
            expect(user.valid?).to eq false
          end
        end
      end
    end

    context "instagram" do
      it "nilは有効" do
        user.instagram = nil
        is_expected.to eq true
      end

      it "空文字は有効" do
        user.instagram = ''
        is_expected.to eq true
      end

      it "30文字以内の[a-zA-Z_.0-9]（先頭末尾に.を用いない）は有効" do
        valid_instagrams = [
          "abc_DEF.123",      # 全パターンの文字列を含む
          "a",                # 最小長：1文字
          "123456789012345678901234567890",  # 最大長：30文字
        ]

        aggregate_failures do
          valid_instagrams.each do |valid_instagram|
            user.instagram = valid_instagram
            expect(user.valid?).to eq true 
          end
        end
      end

      it "30文字以内の[a-zA-Z_.0-9]（先頭末尾に.を用いない）に該当しない場合は無効" do
        valid_instagrams = [
          "abc_DEF.123#",     # 不正な文字を含む（記号）
          "abc_DEF.123あ",    # 不正な文字を含む（全角文字列）
          ".abc_DEF.123",     # 先頭に.を用いる
          "abc_DEF.123.",     # 末尾に.を用いる
          "1234567890123456789012345678901", # 最大長：30文字を超える
        ]

        aggregate_failures do
          valid_instagrams.each do |valid_instagram|
            user.instagram = valid_instagram
            expect(user.valid?).to eq false
          end
        end
      end
    end
  
  end
end

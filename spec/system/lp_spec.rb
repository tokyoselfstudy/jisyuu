# frozen_string_literal: true

require "rails_helper"

RSpec.describe "ランディングページ", type: :system do
  def card_assert_helper (card, member, img, price, benefits_number)
    expect(card.find('div.lp-card-header')).to have_selector 'h4.lp-card-title', text: member
    expect(card.find('div.plans-comparison-box__images')).to have_selector img
    expect(card.find('div.plans-card__body')).to have_selector 'span.lp-price', text: price
    expect(card.find('div.plans-card__body').all('svg.fa-check').size).to eq benefits_number
  end

  def button_assert_helper (element)
    expect(page.find(element)).to have_link 'コミュニティに参加する！', href: 'https://community.camp-fire.jp/projects/view/452788'
  end

  before do
    visit lp_path
  end
  context "lp-image" do
    it "lp-imageのテキストが正しく表示されること" do
      expect(page.find('section.lp-image')).to have_selector 'h1', text: '良い習慣をつくろう'
      expect(page.find('section.lp-image')).to have_selector 'p', text: '「つづく」から「習慣」へ'
    end
  end

  context "lp-lead2" do
    it "イベント一覧のリンクが正しく表示されること" do
      expect(page.find('section.lp-lead2')).to have_link 'イベント一覧を見る', href: events_path
    end
    it "自習会の画像が正しく表示されること" do
      expect(page.find('section.lp-lead2')).to have_selector "img[src$='/images/lp/offline-img.png']"
      expect(page.find('section.lp-lead2')).to have_selector "img[src$='/images/lp/online-img.png']"
    end
    it "コミュニティのリンクボタンが正しく表示されること" do
      button_assert_helper('section.lp-lead2')
    end
  end

  context "lp-plan" do
    let(:first_card) { page.all('section.lp-plan .lp-card')[0] }
    let(:second_card) { page.all('section.lp-plan .lp-card')[1] }
    let(:third_card) { page.all('section.lp-plan .lp-card')[2] }

    it "メンバーカードが正しく表示されること" do
      card_assert_helper(first_card, 'ビジターメンバー', "img[src$='/images/lp/visitor-member.png']", '無料', 1)
      card_assert_helper(second_card, 'コミュニティメンバー', "img[src$='/images/lp/community-member.png']", '¥500', 2)
      card_assert_helper(third_card, 'ファシリテーター', "img[src$='/images/lp/facilitator-member.png']", '¥1000', 3)
    end

    it "コミュニティのリンクボタンが正しく表示されること" do
      button_assert_helper('section.lp-plan')
    end
  end

  context 'lp-qa' do
    it "コミュニティのリンクボタンが正しく表示されること" do
      button_assert_helper('section.lp-qa')
    end
  end
end

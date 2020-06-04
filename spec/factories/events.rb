# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    title { "テストイベント" }
    detail { "テストイベントの詳細" }
    event_date { Date.today - 5.day }
    event_end_date { Date.today - 4.day }
    place_name { "タリーズコーヒー" }
    place_address { "東京都渋谷区" }
    place_url { "https://www.hogehoge.com" }
    num_of_applicant { 10 }
    image { fixture_file_upload(Rails.root.join("spec", "support", "assets", "landescape.jpg"))
    }
    user
    after(:build) do |event|
      FactoryBot.build(:room, event: event)
    end
  end
end

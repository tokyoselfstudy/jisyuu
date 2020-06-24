# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    pref_id { 13 }
    users_category_id { 1 }
    users_job_category_id { 4 }
    family_name { "田中" }
    first_name { "太郎" }
    family_name_kana { "たなか" }
    first_name_kana { "たろう" }
    gender { "male" }
    studying { "プログラミング" }
    introduction { "こんにちは..." }
    birthdate { "1989-03-11" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { "hogehogefoobar" }
    is_manager { false }
    confirmed_at { Date.today }
    avatar { fixture_file_upload(Rails.root.join("spec", "support", "assets", "landescape.jpg"))
    }
  end

  factory :manager_user, class: User do
    family_name { "コミュニティ" }
    first_name { "管理者" }
    sequence(:email) { |n| "manager_tester#{n}@example.com" }
    password { "hogehogefoobar" }
    is_manager { true }
    confirmed_at { Date.today }
  end

  factory :new_registration_confirmed_user, class: User do
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { "hogehogefoobar" }
    confirmed_at { Date.today }
  end
end

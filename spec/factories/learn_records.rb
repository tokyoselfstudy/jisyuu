# frozen_string_literal: true

FactoryBot.define do
  factory :learn_record do
    association :study_category, factory: :study_category

    title { "テストブログ" }
    is_published { true }
    is_deleted { false }
    content { "テストブログ" }
    user
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :study_category do
    initialize_with { StudyCategory.find_or_initialize_by(name: name) }

    name { "テストカテゴリー" }
  end
end

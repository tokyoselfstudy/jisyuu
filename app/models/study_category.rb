# frozen_string_literal: true

class StudyCategory < ApplicationRecord
  has_many :learn_records
end

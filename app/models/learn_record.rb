# frozen_string_literal: true

class LearnRecord < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  belongs_to :study_category
  has_one_attached :thumbnail
  validate :thumbnail_validate

  belongs_to :user, optional: true
  belongs_to :event, optional: true

  has_rich_text :content

  scope :with_study_category, -> { joins(:study_category) }
  scope :user_learn_records, -> (user_id) do
    return where(nil) if user_id.blank?
    with_study_category.eager_load(:study_category).where(user_id: user_id, is_deleted: false)
  end

  def thumbnail_validate
    if thumbnail.attached?
      if !thumbnail.content_type.in?(%('image/jpeg image/png'))
        errors.add(:thumbnail, "にはjpegまたはpngファイルを添付してください")
      elsif thumbnail.blob.byte_size > 10.megabytes
        errors.add(:thumbnail, "ファイルのサイズが大きすぎます")
      end
    end
  end
end

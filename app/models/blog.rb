class Blog < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  has_one_attached :thumbnail
  validate :thumbnail_validate

  has_rich_text :content

  def thumbnail_validate
    if thumbnail.attached?
      if !thumbnail.content_type.in?(%('image/jpeg image/png'))
        errors.add(:thumbnail, "にはjpegまたはpngファイルを添付してください")
      elsif thumbnail.blob.byte_size > 10.megabytes
        errors.add(:thumbnail, "ファイルのサイズが大きすぎます")
      end
    else
      errors.add(:thumbnail, "ファイルを添付してください")
    end
  end

  scope :blogs_index, -> { where(is_deleted: false, is_published: true) }
end

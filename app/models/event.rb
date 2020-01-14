class Event < ApplicationRecord
  validates :title, presence: true
  validates :num_of_applicant, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :event_date, presence: true
  validates :event_end_date, presence: true
  validates :place_name, presence: true
  validates :reason, presence: true

  has_one_attached :image
  validate :image_presence
  belongs_to :user


  def image_presence
    if image.attached?
      if !image.content_type.in?(%('image/jpeg image/png'))
        errors.add(:image, 'にはjpegまたはpngファイルを添付してください')
      elsif image.blob.byte_size > 10.megabytes
        errors.add(:image, 'ファイルのサイズが大きすぎます')
      end
    else
      errors.add(:image, 'ファイルを添付してください')
    end
  end
end

class Event < ApplicationRecord
  validates :title, presence: true
  validates :num_of_applicant, presence: true, numericality: { greater_than_or_equal_to: 1 }
  validates :event_date, presence: true
  validates :event_end_date, presence: true
  validates :place_name, presence: true
  validates :reason, presence: true

  has_one_attached :image
  validate :image_presence

  has_many :events_users
  has_many :participants_user, through: :events_users
  belongs_to :user

  scope :with_events_user, -> { joins(:events_users) }
  scope :upcoming_events, -> (user_id) do
    return where(nil) if user_id.blank?
    with_events_user.merge(EventsUser.where(user_id: user_id)).where('event_date > ?', Time.zone.now)
  end

  scope :past_events, -> (user_id) do
    return where(nil) if user_id.blank?
    with_events_user.merge(EventsUser.where(user_id: user_id)).where('event_date < ?', Time.zone.now)
  end

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

  def participate_count
    EventsUser.where(event_id: self.id).count
  end

  def event_date_shape
    event_date.strftime("%-m月%-d日(#{%w(日 月 火 水 木 金 土)[event_date.wday]}) %-H時%-M分")
  end

  def event_end_date_shape
    event_end_date.strftime("%-H時%-M分")
  end

  def price_label
    self.fee == 0 ? '無料' : self.fee 
  end
end

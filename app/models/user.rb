# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_one_attached :avatar
  validate :avatar_presence

  has_many :event
  has_many :events_users

  def avatar_presence
    if avatar.attached?
      if !avatar.content_type.in?(%('image/jpeg image/png'))
        errors.add(:avatar, "にはjpegまたはpngファイルを添付してください")
      elsif avatar.blob.byte_size > 10.megabytes
        errors.add(:avatar, "ファイルのサイズが大きすぎます")
      end
    else
      errors.add(:avatar, "ファイルを添付してください")
    end
  end

  def view_full_name
    "#{self.family_name} #{self.first_name}"
  end
end

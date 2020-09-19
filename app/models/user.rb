# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  KATAKANA_REGEXP = /\A[\p{katakana}\u{30fc}]+\z/
  FAMILY_FIRST_NAME_REGEXP = /\A[\p{katakana}\p{Han}\p{Hiragana}]+\z/
  validates :family_name, :first_name, presence: true, format: { with: FAMILY_FIRST_NAME_REGEXP }, on: :update, unless: :encrypted_password_changed?
  validates :family_name_kana, :first_name_kana, presence: true, format: { with: KATAKANA_REGEXP }, on: :update, unless: :encrypted_password_changed?
  validates :studying, :introduction, :gender, :birthdate, :email, presence: true, on: :update, unless: :encrypted_password_changed?

  has_one_attached :avatar
  validate :avatar_presence, on: :update, unless: :encrypted_password_changed?

  has_many :events
  has_many :events_users
  has_many :learn_records

  def avatar_presence
    if avatar.attached?
      if !avatar.content_type.in?(%('image/jpeg image/png image/jpg'))
        errors.add(:avatar, "にはjpeg/png/jpgいづれかのファイルを添付してください")
      elsif avatar.blob.byte_size > 10.megabytes
        errors.add(:avatar, "ファイルのサイズが大きすぎます")
      end
    else
      errors.add(:avatar, "ファイルを添付してください")
    end
  end

  def display_priority_nickname
    self.nickname.present? ? self.nickname : self.view_full_name
  end

  def view_full_name
    "#{self&.family_name} #{self&.first_name}"
  end

  def is_manager?
    self.is_manager
  end
end

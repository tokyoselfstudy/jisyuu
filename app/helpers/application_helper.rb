# frozen_string_literal: true

module ApplicationHelper
  require "uri"
  def flash_background_color(key)
    case key
    when "notice"
      "success"
    when "alert"
      "danger"
    end
  end

  def is_same_user?(user_id, user_id_2)
    return false unless user_id.present? && user_id_2.present?
    user_id == user_id_2
  end

  # 入力された文字列のセキュリティを担保し改行があればbrタグを入れる
  def hbr(text)
    text = html_escape(text)
    text.gsub(/\r\n|\r|\n/, "<br />")
  end

  # uriを含む文字列であれば、aタグに置き換える
  def text_url_to_link(text)
    URI.extract(text, ["http", "https"]).uniq.each do |url|
      text.gsub!(url, "<a href=\"#{url}\" target=\"_blank\">#{url}</a>")
    end
    text
  end
end

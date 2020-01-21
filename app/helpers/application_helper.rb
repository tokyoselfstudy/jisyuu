module ApplicationHelper
  def flash_background_color(key)
    case key
    when 'notice'
      'success'
    when 'alert'
      'danger'
    end
  end
end

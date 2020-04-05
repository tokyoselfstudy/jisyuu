# frozen_string_literal: true

module UsersHelper
  
  def gender_active_controll(gender_string, ck_box)
    return if gender_string == nil
    gender_string == ck_box ? 'active' : ''
  end
end

module AdminConcern
  extend ActiveSupport::Concern

  # 管理画面にアクセス可能なユーザーかどうか
  def is_admin_user?
    return false unless user_signed_in?
    return false unless current_user.is_admin
    true
  end
end

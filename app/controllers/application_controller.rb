class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger

  def is_manager?
    return redirect_to '/', alert: 'イベントの作成・変更権限がありません。' if user_signed_in? && !current_user.is_manager
  end
end

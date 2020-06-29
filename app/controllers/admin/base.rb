
class Admin::Base < ApplicationController
    include AdminConcern
    before_action :redirect_root_not_admin

    private

      def redirect_root_not_admin
        logger.debug('はしったよ')
        redirect_to root_path unless is_admin_user?
      end
  end
  
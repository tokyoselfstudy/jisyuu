class Admin::UsersController < ApplicationController
  include AdminConcern
  before_action :redirect_root_not_admin
  
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.is_manager = user_params[:is_manager]
    if @user.save
      flash[:notice] = "ユーザー情報の更新に成功しました。"
      redirect_to admin_users_path
    else
      flash[:alert] = "ユーザー情報の更新に失敗しました。"
      render :show
    end
  end

  private
    def search_params
      params.require(:q).permit(:family_name_or_first_name_cont)
    end

    def user_params
      params.require(:user).permit(:is_manager)
    end 

    def redirect_root_not_admin
      redirect_to root_path if !is_admin_user?
    end
end

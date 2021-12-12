# frozen_string_literal: true

class LearnRecordsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :new, :create, :edit, :update, :destroy, :menu]
  before_action :correct_user?, only: [:edit, :update, :destroy, :menu]

  def index
    @learn_records = LearnRecord.publish.order(created_at: :desc)
  end

  def new
    @learn_record = LearnRecord.new
  end

  def show
    @learn_record = LearnRecord.find(params[:id])
  end

  def create
    @learn_record = current_user.learn_records.build(learn_record_params)
    if @learn_record.save
      flash[:notice] = "ブログの作成に成功しました。"
      redirect_to learn_record_path(@learn_record)
    else
      flash[:danger] = "ブログの作成に失敗しました。"
      render :new
    end
  end

  def edit
  end

  def update
    if @learn_record.update_attributes(learn_record_params)
      flash[:notice] = "ブログの更新に成功しました。"
      redirect_to learn_record_path(@learn_record)
    else
      flash[:danger] = "ブログの更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @learn_record.is_deleted = true
    if @learn_record.save
      flash[:notice] = "ブログの削除に成功しました。"
      redirect_to learn_records_path
    else
      flash[:danger] = "ブログの削除に失敗しました。"
      render :index
    end
  end

  def menu
    @learn_record = LearnRecord.find(params[:id])
  end

  private
    def learn_record_params
      params.require(:learn_record).permit(:title, :content, :thumbnail, :study_category_id, :is_published, :is_deleted)
    end

    def correct_user?
      @learn_record = LearnRecord.find(params[:id])
      view_context.is_same_user?(current_user.id, @learn_record.user_id)
    end
end

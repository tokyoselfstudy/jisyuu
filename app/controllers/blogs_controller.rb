# frozen_string_literal: true

class BlogsController < ApplicationController
  include AdminConcern
  before_action :is_admin_user?, only: [:new, :create, :edit, :update, :destroy]

  def index
    @blogs = Blog.blogs_index.order(:created_at).page(params[:page]).per(8)
  end

  def new
    @blog = Blog.new
  end

  def show
    @is_admin_user = is_admin_user?
    @blog = Blog.find(params[:id])
    return head 404 if @blog.is_deleted == true
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      flash[:notice] = "ブログの作成に成功しました。"
      redirect_to blog_path(@blog)
    else
      flash[:danger] = "ブログの作成に失敗しました。"
      render :new
    end
  end

  def edit
    @blog = Blog.find(params[:id])
  end

  def update
    @blog = Blog.find(params[:id])
    if @blog.update_attributes(blog_params)
      flash[:notice] = "ブログの更新に成功しました。"
      redirect_to blog_path(@blog)
    else
      flash[:danger] = "ブログの更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.is_deleted = true
    if @blog.save
      flash[:notice] = "ブログの削除に成功しました。"
      redirect_to menu_path
    else
      flash[:danger] = "ブログの削除に失敗しました。"
      render :new
    end
  end

  private
    def blog_params
      params.require(:blog).permit(:title, :content, :thumbnail, :is_published, :is_deleted)
    end
end

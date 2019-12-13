class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_current_user
  before_action :check_current_page
  before_action :exist_admin_post

  def check_current_page
    @current_page = params[:page].nil? ? 1 : params[:page].to_i
  end

  def exist_admin_post
    @admin = User.find_by(email: 'admin@example.com', admin: true)
  end

  def set_current_user
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user
    unless @current_user
      flash[:notice] = "ログインしてください"
      redirect_to login_url
    end
  end

  def limitation_login_user
    if @current_user
      flash[:notice] = "すでにログインしています"
      redirect_to posts_page_index_url(1)
    end
  end
end

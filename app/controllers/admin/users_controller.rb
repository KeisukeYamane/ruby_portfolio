class Admin::UsersController < ApplicationController
    # before_action :set_current_user
  # before_action :check_admin_user
  before_action :exist_admin_post
  # before_action :limitation_corrct_user


  def index
    if @admin
     if @admin_post = Post.where(user_id: @admin.id).order(id: "DESC")
     end
    else
      redirect_to posts_page_index_url(1)
    end
  end
end

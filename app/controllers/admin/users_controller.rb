class Admin::UsersController < ApplicationController
  before_action :exist_admin_post


  def index
    if @admin
     if @admin_post = Post.where(user_id: @admin.id).order(id: "DESC")
     end
    else
      redirect_to posts_page_index_url(1)
    end
  end
end

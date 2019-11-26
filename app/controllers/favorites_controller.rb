class FavoritesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @favorite = Favorite.new(
      post_id: params[:post_id]
    )
    if !@current_user.nil?
      @favorite.user_id = @current_user.id
      if !@favorite.save
      redirect_to posts_path(params[:post_id])
      end
    end
  end

  def destroy
    if !@current_user.nil?
      @post = Post.find(params[:post_id])
      @favorite = Favorite.find_by(post_id: params[:post_id], user_id: @current_user.id)
      if !@favorite.destroy
      redirect_to posts_path(params[:post_id])
      end
    end
  end

 
  def favorite_params
    params.require(:favorite).permit(:post_id, :user_id)
  end

  # private
  # def user_params
  #   params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  # end
end

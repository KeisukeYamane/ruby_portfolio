class HomesController < ApplicationController
  def top
  end

  def about
  end

  def all
    @user = User.all
    @post = Post.all
  end
end

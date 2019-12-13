class UsersController < ApplicationController
  before_action :authenticate_user, only: [:index, :edit, :update, :destroy]
  before_action :limitation_login_user, only: [:new, :create, :login_page, :login]
  before_action :limitation_corrct_user, only: [:edit, :update, :destroy]

  def limitation_corrct_user
    unless @current_user.id == params[:id].to_i || @current_user.admin?
      flash[:notice] = "他のユーザーは行うことができません"
      redirect_to posts_page_index_url(@current_page)
    end
  end

  def index
    @user = User.all.order(id: "DESC")
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.image = 'default.png'
    # binding.pry
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "登録完了しました"
      redirect_to user_url(@user.id)
    else
      render :new
    end
  end

  def show
      @user = User.find(params[:id])
      @favorite_posts = @user.favorite_posts
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    if params[:upfile]
      file = params[:upfile]
      @user.image = "#{@user.id}_" + file.original_filename
      output_path = Rails.root.join('public/user_image', @user.image)
      File.open(output_path, 'wb'){ |f| f.write(file.read) }
    end

    if @user.save
      flash[:notice] = "ユーザー情報の編集ができました"
      redirect_to user_url @user
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    if @current_user.admin?
      flash[:notice] = "管理者権限によりアカウントを削除しました"
      redirect_to users_url
    else
      session[:user_id] = nil
      redirect_to posts_page_index_url(@current_page)
    end
  end

  def login_page
  end

  def login
    @user = User.find_by(login_params)

    if @user && @user.authenticate(password_params[:password])
      session[:user_id] = @user.id
      flash[:notice] = "ログイン完了しました"
      redirect_to posts_page_index_url(@current_page)
    else
      @error_message = "メールアドレスまたは、パスワードが間違っています"
      render :login_page
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to posts_page_index_url(@current_page)
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end

  def login_params
    params.require(:users).permit(:email)
  end

  def password_params
    params.require(:users).permit(:password)
  end
end

class PostsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create, :edit, :update, :destroy]
  before_action :limitation_corrct_user, only: [:edit, :update, :destroy]

  def index
      @current_page = params[:page].nil? ? 1 : params[:page].to_i
      # @posts = Post.all.order(created_at: :desc)
      @max_page = (Post.all.size.to_f / 3).ceil
      if @max_page == 0
        @current_page = 1
      elsif @current_page > @max_page && @max_page != 0
        @current_page = @max_page
      end
      @posts = Post.all.order(created_at: :desc).limit(3).offset(3 * (@current_page -1))
      @pagenation = {}
      @pagenation['<<'] = 1 if @max_page >= 5 && @current_page >= 4
      if @max_page >= 4 && @current_page >= 3
        if @current_page == @max_page
          @pagenation['<'] = @current_page - 3
        else
          @pagenation['<'] = @current_page - 2
        end
      end

      if @max_page >= 0 && @max_page == @current_page
        @pagenation.merge!({@current_page - 2 => @current_page - 2, @current_page - 1 => @current_page - 1, @current_page => @current_page})
      else
        @pagenation.merge!({@current_page - 1 => @current_page - 1, @current_page => @current_page })
      end

      delete_list = [0, -1]
      @pagenation.delete_if do |key, value|
        delete_list.include?(value)
      end

      if @current_page == 1 && @max_page >= 3
        @pagenation.merge!({@current_page + 1 => @current_page + 1, @current_page + 2 => @current_page + 2 })
      elsif (@current_page == 1 && @max_page == 2) || (@current_page != 1 && @max_page != @current_page)
        @pagenation.merge!({@current_page + 1 => @current_page + 1 })
      end
      if @max_page >= 4 && @current_page == 1
        @pagenation['>'] = @current_page + 3
      elsif (@max_page >= 4 && @current_page != 1 && @max_page - @current_page >= 2)
        @pagenation['>'] = @current_page + 2
      end
      @pagenation['>>'] = @max_page if @max_page >= 5 && @max_page - @current_page >= 3

    respond_to do |format|
      format.html
      format.js
    end

  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(
      # title: params[:post][:title],
      # content: params[:post][:content],
      # post_image: params[:upfile]
      #ここで紐付けを行う。
      post_params
      )
      @post.user_id = @current_user.id
      #下で定義されている画像アップロード処理に移る
      upload_image 
      # @post.save
      # これでデータベースに投稿内容が保存される
      # そしてリダイレクト処理を行う
      if @post.save
      flash[:notice] = '投稿に成功しました'
      if @current_user.admin?
        redirect_to notice_url
      else
        redirect_to posts_page_index_url(1)
      end
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])#削除可、limitation_corrct_userで定義されるから。

  end

  def update
    @post = Post.find(params[:id])#削除可
    # @post.title = params[:post][:title]
    # @post.content = params[:post][:content]
    @post.update(post_params )
    upload_image
    if @post.save
      flash[:notice] = '投稿を編集しました'
      redirect_to user_path(@post.user_id)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])#削除可
    if @post.destroy
      flash[:notice] = '投稿を削除しました'
      redirect_to user_path(@post.user_id)
    else
      flash[:notice] = '投稿が削除できませんでした'
      redirect_to user_url(@post.user.id)
    end
  end

  def limitation_corrct_user
    @post = Post.find(params[:id])
    unless @post.user_id == @current_user.id || @current_user.admin?
      flash[:notice] = "自分以外のユーザーの編集はできません"
      redirect_to posts_page_index_url(1)
    end
  end

  def upload_image
    if params[:upfile]
      file = params[:upfile]
      @post.post_image = "#{@current_user.id}_" + file.original_filename
      output_path = Rails.root.join('public/post_image', @post.post_image)
      File.open(output_path, 'wb'){ |f| f.write(file.read) }
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :content, :post_image)
  end
end

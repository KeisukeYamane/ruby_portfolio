require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  
  #正常にレスポンスを返すこと
  it "#index responds successfully" do
    get :index
    expect(response).to be_success
  end
  
  #200レスポンスを返すこと
  it "#index returns 200 responds" do
    get :index
    expect(response).to have_http_status(200)
  end
  
  describe "#show" do
    before do
      @post = FactoryBot.create(:post)
    end
    
    context "has post.id" do
      #params[:id]があれば正常にレスポンスを返すこと
      it "responds successfully" do
        get :show, params: { id: @post.id }
        expect(response).to be_success
      end
      
      #params[:id]があれば200をかえすこと
      it "returns 200 responds" do
        get :show, params: { id: @post.id }
        expect(response).to have_http_status(200)
      end
    end
  end
  
  describe "#new" do
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user)
        session[:user_id] = @user.id
      end
      #session[:user_id]があれば正常にレスポンスを返すこと
      it "responds successfully" do
        get :new
        expect(response).to be_success
      end
      
      #session[:user_id]があれば200レスポンスを返すこと
      it "returns 200 responds" do
        get :new
        expect(response).to have_http_status(200)
      end
    end
    context "as a guest" do
      #ログイン画面にリダイレクトすること
      it "redirect to login page" do
        get :new
        expect(response).to redirect_to "/login"
      end
      
      #302レスポンスを返すこと
      it "returns 302 responds" do
        get :new
        expect(response).to have_http_status(302)
      end
    end
    
  end
  
  describe "#create" do
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user)
        session[:user_id] = @user.id
      end
      #session[:user_id]があれば投稿できること
      # it "adds a post" do
      #   post_params = FactoryBot.attributes_for(:post)
      #   expect(
      #     post :create, params: {post: post_params} ).to change(@user.posts, :count).by(1)
      #   end
      end
      
      context "as a guest" do
        #ログイン画面にリダイレクトすること
        it "redirect to login page" do
          post_params = FactoryBot.attributes_for(:post)
          post :create, params: {post: post_params}
          expect(response).to redirect_to "/login"
        end
        #302レスポンスを返すこと
        it "returns 302 responds" do
          post_params = FactoryBot.attributes_for(:post)
          post :create, params: {post: post_params}
          expect(response).to have_http_status(302)
        end
      end
    end
  end

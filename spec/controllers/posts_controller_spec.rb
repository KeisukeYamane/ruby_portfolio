require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  describe "#index" do
    #正常にレスポンスを返すこと
    it "responds successfully" do
      get :index
      expect(response).to be_success
    end
  
    #200レスポンスを返すこと
      it "returns 200 responds" do
      get :index
      expect(response).to have_http_status(200)
    end
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
    before do
      filepath = "spec/test_images/test.png"
      @test_image_file = fixture_file_upload(filepath, "image/png")
    end
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user)
        @post_and_user = FactoryBot.create(:post)
        session[:user_id] = @post_and_user.user_id
      end

      context "with valid attributes" do
          #session[:user_id]があれば投稿できること
          it "adds a post" do
           post_params = FactoryBot.attributes_for(:post)
            expect{
              post :create, params: {post: post_params, upfile: @test_image_file} }.to change(@post_and_user.user.posts, :count).by(1)
          end
      end

       context "with invalid attributes" do
          it "does not add a post" do
            post_params = FactoryBot.attributes_for(:post, :invalid)
            expect{
              post :create, params: {post: post_params, upfile: @test_image_file} }.not_to change(@post_and_user.user.posts, :count)
            end
       end
    end
      
      context "as a guest" do
        #ログイン画面にリダイレクトすること
        it "redirects to login page" do
          post :create, params: {post: @post, upfile: @test_image_file}
          expect(response).to redirect_to "/login"
        end
        #302レスポンスを返すこと
        it "returns 302 responds" do
          post :create, params: {post: @post, upfile: @test_image_file}
          expect(response).to have_http_status(302)
        end
      end
    end

    describe "#update" do
    #認可されたユーザーとして
      context "as an authorized user" do
        before do
          @post = FactoryBot.create(:post)
          session[:user_id] = @post.user_id
        end
        #updateできること
        it "updates a post" do
          post_params = FactoryBot.attributes_for(:post, :empty, title: "Good morning")
          patch :update, params: {id: @post.id, post: post_params}
          expect(@post.reload.title).to eq("Good morning")
        end
      end

        #認可されていないユーザーとして
        context "as an unauthorized user" do
          before do
            #assosiationでユーザーを2人作成、それぞれにpostを持たせるが、2人目のuserでログインをしている状態
            @post = FactoryBot.create(:post)
            @other_post = FactoryBot.create(:post, title: "Sorry")
            session[:user_id] = @other_post.user_id
          end
          #2理目のユーザーが1人目のユーザーの投稿をupdateしようとするも、できない
          it "dose not update a someone's post" do
            post_params = FactoryBot.attributes_for(:post, :empty, title: "Hey!")
            patch :update, params: {id: @post.id, post: post_params}
            expect(@post.reload.title).to eq("Hello")
          end

          #投稿一覧画面にリダイレクトされる
          it "redirecits to posts_page" do
            post_params = FactoryBot.attributes_for(:post, :empty, title: "Hey!")
            patch :update, params: {id: @post.id, post: post_params}
            expect(response).to redirect_to "/posts/1/index"
          end
        end

        #ログインを済ませていないゲストとして
        context "as a guest" do
          before do
            @post = FactoryBot.create(:post)
          end

          #302レスポンスを返すこと
          it "returns 302 responds" do
            post_params = FactoryBot.attributes_for(:post, title: "Say")
            patch :update, params: {id: @post.id, post: post_params}
            expect(response).to have_http_status(302)
          end

          it "redirects to login page" do
            post_params = FactoryBot.attributes_for(:post, title: "Say")
            patch :update, params: {id: @post.id, post: post_params}
            expect(response).to redirect_to("/login")
          end
        end

        describe "#destroy" do
          #認可されているユーザーとして
          context "as an authorized user" do
            before do
              @post = FactoryBot.create(:post)
              session[:user_id] = @post.user_id
            end
            #投稿を削除できる
            it "deletes a post" do
              expect{ delete :destroy, params: {id: @post.id}}.to change(@post.user.posts, :count).by(-1)
            end
          end
          #認可されていないユーザーとして
          context "as an unauthorized user" do
            before do
              @post = FactoryBot.create(:post)
              @other_post = FactoryBot.create(:post)
              session[:user_id] = @other_post.user_id
            end
            #投稿を削除できない
            it "does not delete post" do
              expect { delete :destroy, params: {id: @post.id}}.not_to change(@post.user.posts, :count)
            end
            #投稿一覧にリダイレクトされる
            it "redirects to post_page" do
              expect(delete :destroy, params: {id: @post.id}).to redirect_to "/posts/1/index"
            end
          end
          context "as a guest" do
            before do
              @post = FactoryBot.create(:post)
            end
            it "returns 302 response" do
              expect( delete :destroy, params: {id: @post.id}).to have_http_status(302)
            end

            it "refirects to login page" do
              expect( delete :destroy, params: {id: @post.id}).to redirect_to "/login"
            end
          end
        end
    end
  end
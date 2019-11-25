require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "#index" do
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user)
        session[:user_id] = @user.id
      end
      #正常にレスポンスを返すこと
      it "responded successfully" do
        get :index
        expect(response).to be_success
      end

      #200レスポンスを返すこと
      it "returns 200 responds" do
        get :index
        expect(response).to have_http_status(200)
      end
    end

    context "as a guest" do
      before do
        @user = FactoryBot.create(:user)
      end
      #正常にレスポンスを返さないこと
      it "does not respond successfully" do
        get :index
        expect(response).not_to be_success
      end

      #302レスポンスを返すこと
      it "returns 302 responds" do
        get :index
        expect(response).to have_http_status(302)
      end

      #ログインページにリダイレクトすること
      it "redirects to login page" do
        get :index
        expect(response).to redirect_to "/login"
      end
    end
  end

  describe "#show" do
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user)
        session[:user_id] = @user.id
      end
      context "has user.id" do
        it "responds successfully" do
          get :show, params: {id: @user}
          expect(response).to be_success
        end

        it "returns 200 responds" do
          get :show, params: {id: @user}
          expect(response).to have_http_status(200)
        end
      end
    end
  end

  describe "#new" do
    it "responds successfully" do
      get :new
      expect(response).to be_success
    end
    
    #200レスポンスを返すこと
    it "returns 200 responds" do
      get :new
      expect(response).to have_http_status(200)
    end
  end

  describe "#create" do
    #正しい属性値なら
    context "with valid attributes" do
      #/users/にリダイレクトされること
      it "make a new user" do
        user_params = FactoryBot.attributes_for(:user, :image)
        # binding.pry
        expect{post :create, params: {user: user_params}}.to change(User, :count).by(1)
      end
    end
    context "with invalid attributes" do
      #newにrenderされること
      it "does not make a new user" do
        user_params = FactoryBot.attributes_for(:user, :invaild_name)
        expect(post :create, params: {user: user_params}).to have_http_status(200)
      end
    end
  end

  describe "#update" do
    context "as an authenticated user" do
      before do
        @user = FactoryBot.create(:user)
        session[:user_id] = @user.id
      end
      it "update a user" do
        user_params = FactoryBot.attributes_for(:user, name: "michel")
        patch :update, params: {id: @user.id, user: user_params}
        expect(@user.reload.name).to eq("michel")
      end
    end

    context "as an unauthenticated user" do
      before do
        @user = FactoryBot.create(:user)
        @other_user = FactoryBot.create(:user, name: "ken")
        session[:user_id] = @user.id
      end
      #他のユーザーの編集は行えないこと
      it "dose not update a other user" do
        user_params = FactoryBot.attributes_for(:user, name: "michel")
        patch :update, params: {id: @other_user.id, user: user_params}
        expect(@other_user.reload.name).to eq("ken")
      end
    end

    context "as a guest" do
      before do
        @user = FactoryBot.create(:user)
      end
      it "returns 302 responds" do
        user_params = FactoryBot.attributes_for(:user, name: "ken")
        patch :update, params: {id:@user.id, user: user_params}
        expect(response).to have_http_status(302)
      end
      it "redirects to login page" do
        user_params = FactoryBot.attributes_for(:user, name: "ken")
        patch :update, params: {id: @user.id, user: user_params}
        expect(response).to redirect_to "/login"
      end
    end

    describe "#destroy" do
      context "as an authorized user" do
        before do
          @user = FactoryBot.create(:user)
          session[:user_id] = @user.id
        end
        it "destroy a user account" do
          expect{delete :destroy, params: {id: @user.id}}.to change(User, :count).by(-1)
        end
      end

      context "as an unauthorized user" do
        before do
          @user = FactoryBot.create(:user)
          @other_user = FactoryBot.create(:user)
          session[:user_id] = @user.id
        end
        it "does not destroy user account" do
          expect{delete :destroy, params: {id: @other_user.id}}.not_to change(User, :count)
        end
      end

      context "as a guest" do
        before do
          @user = FactoryBot.create(:user)
        end
        it "returns 302 respons" do
          expect(delete :destroy, params: {id: @user.id}).to have_http_status(302)
        end

        it "redirect to login page" do
          expect(delete :destroy, params: {id: @user.id}).to redirect_to "/login"
        end
      end
    end
  end
end

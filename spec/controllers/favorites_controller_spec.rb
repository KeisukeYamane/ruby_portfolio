require 'rails_helper'

RSpec.describe FavoritesController, type: :controller do
  describe "#create" do
   context "as a user" do
    before do
      @post = FactoryBot.create(:post)
      session[:user_id] = @post.user.id
    end
    #ユーザーが自分の投稿をお気に入りできること
    it "add a favorite　on my post" do
      expect{ post :create, params: {post_id: @post.id}, xhr: true}.to change(Favorite, :count).by(1)
    end
   end

   context "as a user" do
    before do
      @post = FactoryBot.create(:post)
      @other_post = FactoryBot.create(:post)
      session[:user_id] = @post.user.id
    end
    #ユーザーが他人の投稿でもお気に入りできること
    it "add a favorite on other_user'post" do
      expect{ post :create, params: {post_id: @other_post.id}, xhr: true}.to change(Favorite, :count).by(1)
    end
   end

   context "as a guest" do
    before do
      @post = FactoryBot.create(:post)
    end
    it "does not add a favorite" do
      expect{ post :create, params: {post_id: @post.id}, xhr: true}.not_to change(Favorite, :count)
    end
   end
  end

  describe "#destroy" do
   context "as a user" do
    before do
      @favorite = FactoryBot.create(:favorite)
      session[:user_id] = @favorite.user.id
    end
    #ユーザーが自分のお気に入りを解除できること
    it "destroy my favorite's post" do
      expect{ delete :destroy, params: {post_id: @favorite.post.id}, xhr: true}.to change(Favorite, :count).by(-1)
    end
   end

   context "as a guest" do
    before do
      @favorite = FactoryBot.create(:favorite)
    end
    it "does not destroy my favorite's post" do
      expect{ delete :destroy, params: {post_id: @favorite.post.id}, xhr: true}.not_to change(Favorite, :count)
    end
   end
  end
end

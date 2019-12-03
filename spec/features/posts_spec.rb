require 'rails_helper'

RSpec.feature "Posts", type: :feature do
  include LoginSupport
  include NewPostSupport
  #ログインして投稿ができる
  scenario "user can creates a new post" do
    user = FactoryBot.create(:user)
    log_in user
    
    expect {
      click_link "新規投稿"
      expect(current_path).to eq new_post_path
      fill_in "タイトル", with: "Hello"
      fill_in "本文", with: "Hello World"
      attach_file "upfile", "#{Rails.root}/spec/test_images/test.png"
      click_button "投稿"
    }.to change(user.posts, :count).by(1)
  end

  #ログインして投稿をし、その投稿を編集できる
  scenario "user can edit a post" do
    user = FactoryBot.create(:user)

    log_in user
    expect(page).to have_content "ログイン完了しました"
    expect(current_path).to eq posts_page_index_path(page: 1)

    new_post

    expect(current_path).to eq posts_page_index_path(page: 1)
    click_link "Hello"
    click_link "編集"
    expect(current_path).to eq edit_post_path(id: user.posts.ids)
    fill_in "post_title", with: "Say!"
    click_button "投稿する"
    expect(page).to have_content "投稿を編集しました"
  end

  scenario "user can delete a post" do
    user = FactoryBot.create(:user)

    log_in user
    expect(page).to have_content "ログイン完了しました"
    expect(current_path).to eq posts_page_index_path(page: 1)

    new_post

    expect(current_path).to eq posts_page_index_path(page: 1)
    expect {
      click_link "Hello"
      click_link "削除"
      expect(current_path).to eq user_path(id: user.id)
      expect(page).to have_content "投稿を削除しました"
    }.to change(user.posts, :count).by(-1)
  end
end

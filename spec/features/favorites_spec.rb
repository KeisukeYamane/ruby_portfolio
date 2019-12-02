require 'rails_helper'

RSpec.feature "Favorites", type: :feature do
  scenario "user can add favorite to a post", js: true do

    user = FactoryBot.create(:user)
    visit root_path
    click_on "ログイン"
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"
    expect(page).to have_content "ログイン完了しました"
    expect(current_path).to eq posts_page_index_path(page: 1)

    click_link "新規投稿"
    expect(current_path).to eq new_post_path
    fill_in "タイトル", with: "Hello"
    fill_in "本文", with: "Hello World"
    attach_file "upfile", "#{Rails.root}/spec/test_images/test.png"
    click_button "投稿"

    expect(current_path).to eq posts_page_index_path(page: 1)
    click_link "Hello"
    find(".like").click
    expect(page).to have_content "1"
  end

  scenario "user can delete favorite on a post", js: true do
    user = FactoryBot.create(:user)
    visit root_path
    click_on "ログイン"
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"
    expect(page).to have_content "ログイン完了しました"
    expect(current_path).to eq posts_page_index_path(page: 1)

    click_link "新規投稿"
    expect(current_path).to eq new_post_path
    fill_in "タイトル", with: "Hello"
    fill_in "本文", with: "Hello World"
    attach_file "upfile", "#{Rails.root}/spec/test_images/test.png"
    click_button "投稿"

    expect(current_path).to eq posts_page_index_path(page: 1)
    click_link "Hello"
    find(".like").click
    expect(page).to have_content "1"

    find(".dislike").click
    expect(page).to have_content "0"
  end
end

require 'rails_helper'

RSpec.feature "Favorites", type: :feature do
  include LoginSupport
  include NewPostSupport

  scenario "user can add favorite to a post", js: true do

    user = FactoryBot.create(:user)

    log_in user
    expect(page).to have_content "ログイン完了しました"
    expect(current_path).to eq posts_page_index_path(page: 1)

    new_post

    expect(current_path).to eq posts_page_index_path(page: 1)
    click_link "Hello"
    find(".like").click
    expect(page).to have_content "1"
  end

  scenario "user can delete favorite on a post", js: true do
    user = FactoryBot.create(:user)

    log_in user
    expect(page).to have_content "ログイン完了しました"
    expect(current_path).to eq posts_page_index_path(page: 1)

    new_post

    expect(current_path).to eq posts_page_index_path(page: 1)
    click_link "Hello"
    find(".like").click
    expect(page).to have_content "1"

    find(".dislike").click
    expect(page).to have_content "0"
  end
end

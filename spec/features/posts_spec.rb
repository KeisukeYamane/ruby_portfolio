require 'rails_helper'

RSpec.feature "Posts", type: :feature do
  scenario "user creates a new post" do
    user = FactoryBot.create(:user)

    visit root_path
    click_link "ログイン"
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"

    expect {
      click_link "新規投稿"
      expect(current_path).to eq new_post_path
      fill_in "タイトル", with: "Hello"
      fill_in "本文", with: "Hello World"
      attach_file "upfile", "#{Rails.root}/spec/test_images/test.png"
      click_button "投稿"
    }.to change(user.posts, :count).by(1)
  end
end

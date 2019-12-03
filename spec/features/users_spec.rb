require 'rails_helper'

RSpec.feature "Users", type: :feature do
  include LoginSupport
  #ユーザーを作成できるかどうか
  scenario "user can create user's account" do

    user = FactoryBot.attributes_for(:user)
    visit root_path
    click_link "新規登録"
    expect(current_path).to eq new_user_path

    expect {
      fill_in "名前", with: user[:name]
      fill_in "メールアドレス", with: user[:email]
      fill_in "パスワード", with: user[:password]
      fill_in "パスワード再入力", with: user[:password_confirmation]
      click_button "作成" 
    }.to change(User, :count).by(1)
  end

  scenario "user can edit user's account" do
    user = FactoryBot.create(:user)
    log_in user
    expect(page).to have_content "ログイン完了しました"
    expect(current_path).to eq posts_page_index_path(page: 1)

    click_link "Jhon"
    expect(current_path).to eq user_path(id: user.id)
    click_link "設定/削除"
    click_on "ユーザー情報を編集する"
    expect(current_path).to eq edit_user_path(id: user.id)

    fill_in "user_name", with: "michel"
    fill_in "user_password", with: "1111"
    fill_in "user_password_confirmation", with: "1111"
    click_button "編集する"
    expect(current_path).to eq user_path(id: user.id)

    expect(user.reload.name).to eq("michel")
  end

  scenario "user can delete user's account" do
    
    user = FactoryBot.create(:user)
    log_in user
    expect(page).to have_content "ログイン完了しました"
    expect(current_path).to eq posts_page_index_path(page: 1)

    expect {
      click_link "Jhon"
      expect(current_path).to eq user_path(id: user.id)
      click_link "設定/削除"
      click_on "アカウントを削除する"
      expect(current_path).to eq posts_page_index_path(page: 1)
  }.to change(User, :count).by(-1)
  end
end

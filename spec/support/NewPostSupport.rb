module NewPostSupport
  def new_post 
    click_link "新規投稿"
    expect(current_path).to eq new_post_path
    fill_in "タイトル", with: "Hello"
    fill_in "本文", with: "Hello World"
    attach_file "upfile", "#{Rails.root}/spec/test_images/test.png"
    click_button "投稿"
  end
end
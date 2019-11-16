require 'rails_helper'

#post.rbにおいて
#def user
#  User.find(self.user_id)
#end
#となっているため、便宜上、userはcreateする。

RSpec.describe Post, type: :model do
  #user.idが1であるユーザーが、タイトル、内容、そのユーザーのid、そして画像を持つことは有効であること
  it "is valid with title, content, user_id, and post_image when User exists with user.id=1" do
    User.create(
      name: "Aaron",
      email: "tester@example.com",
      password: "1111",
    )

    post = Post.new(
      title: "こんにちは",
      content: "こんにちは",
      user_id: 1,
      post_image: "test.jpeg",
    )
    post.valid?
    expect(post).to be_valid
  end

  #titleがなければ、無効な状態であること
  it "is invalid without a title" do
    User.create(
      name: "Aaron",
      email: "tester@example.com",
      password: "1111",
    )

    post = Post.new(
      title: nil,
      user_id: 1,
    )
    post.valid?
    expect(post.errors[:title]).to include("を入力してください")
  end

    #contentがなければ、無効な状態であること
    it "is invalid without a content" do
      User.create(
        name: "Aaron",
        email: "tester@example.com",
        password: "1111",
      )
  
      post = Post.new(
        content: nil,
        user_id: 1,
      )
      post.valid?
      expect(post.errors[:content]).to include("を入力してください")
    end

    #post_imageがなければ、無効な状態であること
    it "is invalid without a post_image" do
      User.create(
        name: "Aaron",
        email: "tester@example.com",
        password: "1111",
      )
      
      post = Post.new(
        post_image: nil,
        user_id: 1,
      )
      post.valid?
      expect(post.errors[:post_image]).to include("を入力してください")
    end
end

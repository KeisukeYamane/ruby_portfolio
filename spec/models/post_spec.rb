require 'rails_helper'

#post.rbにおいて
#def user
#  User.find(self.user_id)
#end
#となっているため、便宜上、userはcreateする。

RSpec.describe Post, type: :model do
  let(:post) { FactoryBot.build(:post) }
  #user.idが1であるユーザーが、タイトル、内容、そのユーザーのid、そして画像を持つことは有効であること
  it "is valid with title, content, user_id, and post_image when User exists with user.id=1" do

    post.valid?
    expect(post).to be_valid
  end

  #titleがなければ、無効な状態であること
  it "is invalid without a title" do

    post.title = nil
    post.valid?
    expect(post.errors[:title]).to include("を入力してください")
  end

    #contentがなければ、無効な状態であること
    it "is invalid without a content" do

      post.content = nil
      post.valid?
      expect(post.errors[:content]).to include("を入力してください")
    end

    #post_imageがなければ、無効な状態であること
    it "is invalid without a post_image" do

      post.post_image = nil
      post.valid?
      expect(post.errors[:post_image]).to include("を入力してください")
    end
end

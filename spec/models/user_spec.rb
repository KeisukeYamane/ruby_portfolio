require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user)}
  #名前、メールアドレス、パスワードがあれば有効な状態であること
  it "has a valid factory" do
    expect(user).to be_valid
  end

  # 名前がなければ無効な状態であること
  it "is invalid without a name" do
    user.name = nil
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  describe "password is invalid" do
    #パスワードがなければ無効な状態であること
    it "without a password" do
      user.password = nil
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    #3文字以下なら無効な状態であること
    it "within 3 letters" do
      user.password = "111"
      user.valid?
      expect(user.errors[:password]).to include("は4文字以上で入力してください")
    end
  end

  # メールアドレスがなければ無効な状態であること
  it "is invalid without an email address" do
    user.email = nil
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  # 重複したメールアドレスなら無効な状態であること/2つとも保存内容は同一
  it "is invalid with a duplicate email address" do
    FactoryBot.create(:user, email: "tester@example.com")
    user.email = "tester@example.com"
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end

  #userはpostsを複数持てること
  it "can have many posts" do
    user = FactoryBot.create(:user, :many_posts_with_user)
    expect(user.posts.length).to eq(5)
  end

  # メールアドレスがが正規表現から反していれば、無効な状態であること
  describe "email is invalid" do
    #　@マークを有していない
    it "when a email don't have @" do
      user.email = "testerexample.com"
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end
  
    #　. を有していない
    it "when a email don't have ." do
      user.email = "tester@examplecom"
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end
  end
end

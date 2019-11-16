require 'rails_helper'

RSpec.describe User, type: :model do

  #名前、メールアドレス、パスワードがあれば有効な状態であること
  it "is valid with name, email, and password" do
    user = User.new(
      name: "Aaron",
      email: "tester@example.com",
      password: "1111",
  )
    expect(user).to be_valid
  end

  # 名前がなければ無効な状態であること
  it "is invalid without a name" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end

  describe "password is invalid" do
    it "without a password" do
      user = User.new(password: nil)
      user.valid?
      expect(user.errors[:password]).to include("を入力してください")
    end

    it "within 3 letters" do
      user = User.new(password: "111")
      user.valid?
      expect(user.errors[:password]).to include("は4文字以上で入力してください")
    end
  end

  # メールアドレスがなければ無効な状態であること
  it "is invalid without an email address" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end

  # 重複したメールアドレスなら無効な状態であること/2つとも保存内容は同一
  it "is invalid with a duplicate email address" do
    User.create(
      name: "Aaron",
      email: "tester@example.com",
      password: "1111", 
    )
    user = User.new(
      name: "Aaron",
      email: "tester@example.com",
      password: "1111", 
    )
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end

  # メールアドレスがが正規表現から反して入れば、無効な状態であること
  describe "email is invalid" do
    #　@マークを有していない
    it "when a email don't have @" do
      user = User.new(
        name: "Aaron",
        email: "testerexample.com",
        password: "1111", 
      )
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end
  
    #　. を有していない
    it "when a email don't have ." do
      user = User.new(
        name: "Aaron",
        email: "testerexamplecom",
        password: "1111", 
      )
      user.valid?
      expect(user.errors[:email]).to include("は不正な値です")
    end
  end
end

require 'rails_helper'

RSpec.describe Favorite, type: :model do
  #user_idとpost_idがあればfavoriteは有効であること
  it "can make favorites with user_id and post_id" do
    favorite = FactoryBot.build(:favorite)
    favorite.valid?
    expect(favorite).to be_valid
  end
  #user_idがなければ無効な状態であること
  it "is invalid without an user_id" do
    favorite = FactoryBot.build(:favorite, user_id: nil)
    favorite.valid?
    expect(favorite).not_to be_valid
  end

  #post_idがなければ無効な状態であること
  it "is invalid without an user_id" do
    favorite = FactoryBot.build(:favorite, post_id: nil)
    favorite.valid?
    expect(favorite).not_to be_valid
  end
end

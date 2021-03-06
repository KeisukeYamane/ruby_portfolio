class Post < ApplicationRecord
  attr_accessor :upfile
  validates :title, presence: true, length: { maximum: 40}
  validates :content, presence: true, length: {maximum: 250}
  validates :user_id, presence: true
  validates :post_image, presence: true
  belongs_to :user
  has_many :favorites, dependent: :destroy

  def user
    User.find(self.user_id)
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end

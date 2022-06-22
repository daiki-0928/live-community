class Post < ApplicationRecord
  belongs_to :genre
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, presence:true, length:{maximum:30}
  validates :body, presence:true, length:{maximum:500}

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end

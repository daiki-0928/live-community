class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :favorites, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  enum age: { ten: 0, twenty: 1, thirty: 2, forty: 3, fifty: 4, sixty: 5, seventy: 6, eighty: 7, ninety: 8, other: 9 }

  validates :name, presence:true, length:{maximum:50}
  validates :email, presence:true, length:{maximum:100}
end

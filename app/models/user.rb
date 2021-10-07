class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, uniqueness: true, presence: true, length:{ in: 2..20 }
  validates :introduction, length: {maximum: 50}

  has_many :books, dependent: :destroy
  attachment :profile_image
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorite_books, through: :favorites, source: :book
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
	has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
	has_many :followings, through: :follower, source: :followed
  has_many :followers, through: :followed, source: :follower

    # ユーザーをフォローする
  def follow(other_user)
    unless self == other_user
    follower.create(followed_id: other_user.id)
    end
  end
  # ユーザーのフォローを外す
  def unfollow(other_user)
    follower.find_by(followed_id: other_user.id).destroy
  end
  # フォロー確認をおこなう
  def following?(other_user)
    followings.include?(other_user)
  end

end

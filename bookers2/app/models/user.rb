class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_user, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower # 自分をフォローしている人
  has_many :books_favorite, through: :favorites, source: :book
  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy

  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    following_user.include?(user)
  end

  def self.search(search, word)
    if search == 'forward_match'
      @users = User.where("name LIKE?", "#{word}%")
    elsif search == "backward_match"
      @users = User.where("name LIKE?", "%#{word}")
    elsif search == "perfect_match"
      @users = User.where(name: word)
    else
      @users = User.where("name LIKE?", "%#{word}%")
    end
  end

  attachment :profile_image

  validates :name, presence: true, uniqueness: true, length: { in: 2..20}
  validates :introduction, length: { maximum: 50 }
end

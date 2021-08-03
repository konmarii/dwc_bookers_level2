class Book < ApplicationRecord
  belongs_to :user
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :users_favorite, through: :favorites, source: :user

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def self.search(search, word)
    if search == "forward_match"
      @books = Book.where("title LIKE?", "#{word}%")
    elsif search == "backward_match"
      @books = Book.where("title LIKE?", "%#{word}")
    elsif search == "perfect_match"
      @boosk = Book.where(title: word)
    elsif search == "partial_match"
      @books = Book.where("title LIKE?", "%#{word}%")
    else
      @books = Book.all
    end
  end

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

  is_impressionable counter_cache: true

  scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
  scope :created_this_week, -> { where(created_at: Time.zone.now.all_week) }
  scope :created_last_week, -> { where(created_at: 1.week.ago.all_week) }
end

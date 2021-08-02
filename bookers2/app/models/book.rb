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
        @books = Book.where("title LIKE?","#{word}%")
      elsif search == "backward_match"
        @books = Book.where("title LIKE?","%#{word}")
      elsif search == "perfect_match"
        @boosk = Book.where(title: word)
      elsif search == "partial_match"
        @books = Book.where("title LIKE?","%#{word}%")
      else
        @books = Book.all
      end
    end

    validates :title, presence: true
    validates :body, presence: true, length: { maximum: 200 }
    
    is_impressionable counter_cache: true
end

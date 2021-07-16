class BooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @books = Book.all
    @user = User.find(current_user.id)
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to user_path(id: current_user)
  end

  def edit
  end

  def show
    @book = Book.find(params[:id])
    @user = User.find(current_user.id) 
  end

  def update
  end

  def destroy
  end

  private
  def book_params
  params.require(:book).permit(:title, :opinion, :user_id)
  end
end

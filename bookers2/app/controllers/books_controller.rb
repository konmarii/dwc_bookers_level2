class BooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    @books = Book.all
    @book = Book.new
    @user = User.find(current_user.id)
  end

  def new
    @book = Book.new
  end

  def create
    @books = Book.all
    @book = Book.new(book_params)
    @user = User.find(current_user.id)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id)
      flash[:notice_create_book]="You have created book successfully."
    else
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def show
    @book = Book.find(params[:id])
    @user = User.find(@book.user_id)
  end

  def update
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
    if @book.update(book_params)
      redirect_to book_path
      flash[:notice_update_book]="You have updated book successfully."
    else
      render :edit
      @book = Book.find(params[:id])
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
    flash[:notice_destroy]="Book was successfully destroyed."
  end

  private
  
  def book_params
  params.require(:book).permit(:title, :opinion, :user_id)
  end
end

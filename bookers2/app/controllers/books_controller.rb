class BooksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @books = Book.all
    @book = Book.new
    @user = User.find(current_user.id)
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
    if @book.user == current_user
      render :edit
    else
      render :show
    end
  end

  def show
    if user_signed_in?
      @book = Book.find(params[:id])
      @newbook = Book.new
      @user = User.find(@book.user_id)
    else
      redirect_to user_session_path
    end  
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
  params.require(:book).permit(:title, :body, :user_id)
  end
end

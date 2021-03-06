class UsersController < ApplicationController
  def index
    @users = User.all
    @user = User.find(current_user.id)
    @book = Book.new
    @books = Book.all
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user)
    end
  end

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
    @books_today = @books.created_today
    @books_yesterday = @books.created_yesterday
    @books_this_week = @books.created_this_week
    @books_last_week = @books.created_last_week
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
      flash[:notice_update_user] = "You have updated user successfully."
    else
      render :edit
      @user = User.find(params[:id])
    end
  end

  def follower
    @user = User.find(params[:user_id])
    render 'show_follower'
  end

  def followed
    @user = User.find(params[:user_id])
    render 'show_followed'
  end

  def search
    @user = User.find(params[:user_id])
    @books = @user.books
    @book = Book.new
    if params[:created_at] == ""
      @search_book = "日付を入力してください"
    else
      created_at = params[:created_at]
      @date_books = @books.where(['created_at LIKE ? ', "#{created_at}%"]).count
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end

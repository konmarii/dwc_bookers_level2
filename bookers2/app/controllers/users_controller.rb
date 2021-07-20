class UsersController < ApplicationController

  def index
    @users = User.all
    @user = User.find(current_user.id)
    @book = Book.new
    @books = Book.all
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user.id
      redirect_to show
    else
      render :edit
    end
  end
 
  def show
    if user_signed_in?
      @books = Book.all
      @book = Book.new
      @user = User.find(params[:id])
    else
      redirect_to user_session_path
    end
  end  

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
      flash[:notice_update_user]="You have updated user successfully."
    else
      render :edit
      @user = User.find(params[:id])
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
end

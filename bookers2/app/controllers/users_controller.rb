class UsersController < ApplicationController
  def index
    @users = User.all
    @user = User.find(current_user.id)
    @books = Book.all
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user.id
      render :show
    else
      render :edit
    end
  end
 
  def show
    @books = Book.all
    @user = User.find(params[:id])
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

class HomesController < ApplicationController
  def top
    @user = current_user
  end
  
  def show
    @user = current_user
  end
end

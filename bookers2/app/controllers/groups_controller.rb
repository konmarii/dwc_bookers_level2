class GroupsController < ApplicationController
    def index
        @groups = Group.all
        @user = current_user
        @book = Book.new

    end

    def new
        @group = Group.new
    end

    def create
        @group = Group.new(group_params)
        @user = current_user
        if @group.save
            redirect_to groups_path
            flash[:notice_create_group] = "You have created group successfully."
        else
            render :new
        end
    end

    private
    def group_params
        params.require(:group).permit(:name, :introduction, :image)
    end
end

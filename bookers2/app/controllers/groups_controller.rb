class GroupsController < ApplicationController
    def index
        @groups = Group.all
        @user = current_user
        @book = Book.new
    end

    def show
        @user = current_user
        @newbook = Book.new
        @group = Group.find(params[:id])
    end

    def new
        @group = Group.new
    end

    def create
        @group = Group.new(group_params)
        @group.owner_id = current_user.id
        if @group.save
            redirect_to groups_path
            flash[:notice_create_group] = "You have created group successfully."
        else
            render :new
        end
    end

    def edit
        @group = Group.find(params[:id])
        if @group.owner_id != current_user.id
            redirect_to groups_path
        end
    end

    def update
        @group = Group.find(params[:id])
        @group.owner_id = current_user.id
        if @group.update(group_params)
            redirect_to groups_path
            flash[:notice_update_group] = "You have updated group successfully."
        else
            render :edit
            @group = Group.find(params[:id])
        end
    end

    private
    def group_params
        params.require(:group).permit(:name, :introduction, :image)
    end
end

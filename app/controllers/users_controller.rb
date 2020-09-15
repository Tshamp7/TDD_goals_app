class UsersController < ApplicationController
    def new
        @user = User.new()
        render :new
    end

    def create
        @user = User.new(user_params)
        if @user.valid?
            @user.save
            redirect_to user_path(@user)
        else
            flash.now[:error] = "#{@user.errors.full_messages.join.to_s}"
            render :new
        end
    end

    def show
        @user = User.find_by(id: params[:id])
        render :show
    end

    def update
        User.update_attributes(user_params)
    end

    def edit
        @user = User.find_by(id: params[:id])
        render :edit
    end

    def destroy
        @user = User.find_by(id: params[:id])
        @user.destroy
        render :new
    end

    def index
        @users = User.all
        render :index
    end

    private
        def user_params
            params.require(:user).permit(:email, :password)
        end
    


end

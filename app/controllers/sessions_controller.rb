class SessionsController < ApplicationController
    def create
        user = User.find_by_credentials(
            email: user_params[:email],
            password: user_params[:password]
        )

        if user.nil?
            flash.now[:error] = "Credentials were not correct"
            render :new
        else
            log_in!
            flash[:success] = "Welcome Back #{user.email}!"
            redirect_to user_url(user) 
        end
    end

    def new
        render :new
    end

    def destroy

    end
end

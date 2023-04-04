class SessionsController < ApplicationController
    skip_before_action :authenticate

    def new
    end

    def create
        user = User.find_by(email: params[:email])

        if user&.authenticate(params[:password])
            login_user user
            redirect_to :root
        else
            flash.now.alert = 'No user with those credentials was found'
            render :new
        end
    end

    def destroy
        logout_user
        redirect_to :root
    end
end
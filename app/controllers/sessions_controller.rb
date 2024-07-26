class SessionsController < ApplicationController
    def create
        @user = User.find_by(login:login_params[:login]) 
        return redirect_to '/users/login', alert: "Неправильный логин или пароль" unless @user and @user.authenticate(login_params[:password]) 
        session[:user_id] = @user.id 
        redirect_to @user
    end

    private   
        def login_params
            params.require(:user).permit(:login, :password)
        end
end
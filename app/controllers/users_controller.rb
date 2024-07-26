class UsersController < ApplicationController
  
    def index
    end

    def show
        @user = User.find_by(id:params[:id])
        if @user
            @posts = @user.posts.order(updated_at: :desc).page params[:page]
        else
            redirect_to root_path
        end
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(reg_params)
        if @user.save
            session.clear
            session[:user_id] = @user.id
            redirect_to @user
        else
            render :new, status: :unprocessable_entity
        end
    end

    def edit
        @user = User.find(params[:id])
    end
    
    def update
        @user = User.find(params[:id])
    
        if @user.update(reg_params)
          redirect_to @user
        else
          render :edit, status: :unprocessable_entity
        end
    end
    
    def destroy
        user = User.find_by(id:params[:id])
        if user and user.id == session[:user_id]
            user.destroy
    
            redirect_to login_user_path
        end
    end

    def change_role
        if session[:user_id] && (["redactor", "admin"].include? User.find_by(id:session[:user_id]).role)
            @user = User.find_by(id:params[:id])
            if @user
                @user.update_attribute(:role, reg_params[:role])
            end
            redirect_to user_path
        else
            redirect_to '/error_role'
        end
    end

    def list
        @users = User.order(created_at: :asc).page params[:page]
    end

    def clear
        session.delete(:user_id)
        redirect_to login_user_path
    end

    private
        def reg_params
            params.require(:user).permit(:name, :role, :login, :password, :password_confirmation)
        end
end

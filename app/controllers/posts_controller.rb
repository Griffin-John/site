class PostsController < ApplicationController

    def index
        @posts = Post.order(updated_at: :desc).page params[:page]
    end

    def create
        if ["redactor", "admin"].include? User.find_by(id:session[:user_id]).role
            @post = Post.create(user_id:session[:user_id], body:post_params[:body], title:post_params[:title])
            redirect_to user_path(session[:user_id])
        else
            redirect_to '/error_role'
        end
    end
    
    def show
        @post = Post.find_by(id:params[:id])
    end

    def edit
        if ["redactor", "admin"].include? User.find_by(id:session[:user_id]).role
            @post = Post.find(params[:id])
            @user = User.find_by(id:session[:user_id])
            
        else
            redirect_to '/error_role'
        end
    end

    def update
        @post = Post.find(params[:id])
    
        if @post.update(post_params)
            redirect_to @post
        else
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        if ["redactor", "admin"].include? User.find_by(id:session[:user_id]).role
            @post = Post.find(params[:id])
            @post.destroy
    
            redirect_to root_path
        else
            redirect_to '/error_role'
        end
    end

    private
    def post_params
        params.require(:post).permit(:title, :body)
    end

end

class PostsController < ApplicationController
  def index
    user_id = params[:user_id]
    @user = User.find(user_id)
    @posts = Post.includes(:user).where(user: params[:user_id]).references(:user)
  end

  def show
    @post = Post.includes(:user, comments: [:user]).find(params[:id])
  end

  def new 
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0
    
    if @post.save
      flash[:success] = "Post saved successfully"
      redirect_to @post
    else
      flash.now[:error] = "Error: Post could not be saved"
      render :new, status: :unprocessable_entity
    end
  end
  
  def post_params
    params.require(:post).permit(:title, :text)
  end
  

end

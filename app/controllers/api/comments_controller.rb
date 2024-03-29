class Api::CommentsController < ApplicationController
  load_and_authorize_resource

  def index
    new_id = params[:post_id]
    @comments = Comment.where({ post_id: new_id }).order(:created_at)
    render json: { data: { comments: @comments } }, status: :ok
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end

def create
  @post = Post.find(params[:post_id])
  @comment = @post.comments.new(text: comment_params[:text], user_id: current_user.id, post_id: @post.id)
  if @comment.save
    render json: @comment
  else
    render error: { error: 'Unable to create comments' }, status: 400
  end
end

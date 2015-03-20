class CommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = post.comments.new(params.require(:comment).permit(:content))
    if comment.save
      flash[:notice] = "Comment created!"
    else
      flash[:alert] = "Something went wrong"
    end
    redirect_to post
  end

  def destroy
    post = Post.find(params[:post_id])
    comment = Comment.find(params[:id])
    comment.delete
    flash[:alert] = "Comment Deleted"
    redirect_to post
  end
end
  class CommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    comment = post.comments.new(params.require(:comment).permit(:content))
    comment.user_id = current_user.id
    if comment.save
      flash[:notice] = "Comment created!"
      comment.user.send_message(comment.content)
    else
      flash[:alert] = "Something went wrong"
    end
    respond_to do |format|
      format.html { redirect_to post }
      format.js { }
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    comment = Comment.find(params[:id])
    comment.delete
    flash[:alert] = "Comment Deleted"
    redirect_to post
  end
end

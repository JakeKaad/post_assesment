class CommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    redirect_to post
  end

end
class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new 
    @post = Post.new
  end

  def create
    post = Post.new(params.require(:post).permit(:title, :content))
    if post.save
      flash[:notice] = "Post Created!"
      redirect_to post
    else
      flash[:alert] = "Something went wrong"
      render :new
    end
  end

end
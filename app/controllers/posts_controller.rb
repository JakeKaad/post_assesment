class PostsController < ApplicationController

  before_action :find_post, only: [:show, :edit, :update]

  def index
    @posts = Post.all
  end

  def show
  end

  def new 
    @post = Post.new
  end

  def create
    post = Post.new(post_params)
    if post.save
      flash[:notice] = "Post Created!"
      redirect_to post
    else
      flash[:alert] = "Something went wrong"
      render :new
    end
  end

  def edit 
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "Post Updated!"
      redirect_to @post
    else
      flash[:alert] = "Something went wrong"
      render :edit
    end    
  end

  private
    def find_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content)
    end

end
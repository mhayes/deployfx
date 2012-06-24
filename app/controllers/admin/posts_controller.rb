class Admin::PostsController < Admin::BaseController
  def index
    @posts = Post.all
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(params[:post])
    @post.user = current_user
    if @post.save
      redirect_to edit_admin_post_path(@post)
    else
      render action: :new
    end
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    @post.update_attributes(params[:post])
    redirect_to edit_admin_post_path(@post)
  end
end
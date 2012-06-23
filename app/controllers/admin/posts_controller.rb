class Admin::PostsController < Admin::BaseController
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.create(params[:post])
    redirect_to edit_admin_post_path
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    @post.update_attributes(params[:post])
    redirect_to edit_admin_post_path
  end
end
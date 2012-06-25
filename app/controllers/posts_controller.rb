class PostsController < ApplicationController
  def show
    if admin_signed_in?
      @post = Post.find_by_slug(params[:id])
    else
      @post = Post.published.find_by_slug(params[:id])
    end
    redirect_to root_path unless @post
  end
  
  def archives
    @posts = Post.published
  end
  
  def tagged
    @posts = Post.tagged_with(params[:name].downcase)
    render action: :archives
  end
end
class PostsController < ApplicationController
  def show
    @post = Post.published.find(params[:id])
  end
  
  def archives
    @posts = Post.published
  end
  
  def tagged
    @posts = Post.tagged_with(params[:name].downcase)
    render action: :archives
  end
end
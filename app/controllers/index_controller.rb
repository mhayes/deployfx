
class IndexController < ApplicationController
  def home
    @featured_post = Post.last
    @posts = Post.order_by(:created_at, :desc).limit(3)
  end
  
  def post
  end
  
  def archives
    @posts = Post.all
  end
end


class IndexController < ApplicationController
  def home
    @featured_post = Post.last
    @posts = Post.limit(3)
  end
  
  def post
  end
  
  def archive
    @posts = Post.all
  end
end

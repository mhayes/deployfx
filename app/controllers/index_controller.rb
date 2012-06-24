class IndexController < ApplicationController
  def home
    @posts = Post.recent.published.limit(4)
    @featured_post = @posts.first
    @posts = @posts.skip(1)
    @tags = Post.tags
  end
end

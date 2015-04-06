class PostsController < ApplicationController
  def index
    if params[:tag]
      @posts = Post.published_posts.tagged_with(params[:tag])
    else
      @posts = Post.published_posts
    end
  end

  def show
    @post = Post.find(params[:id])
    #@related_posts = Post.find_by_category_id(@post.category.id)
  end
end

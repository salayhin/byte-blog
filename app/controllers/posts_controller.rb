class PostsController < ApplicationController

  def index
    if params[:tag]
      @posts = Post.published_posts.tagged_with(params[:tag])
    else
      @posts = Post.published_posts
    end

    @categories = Category.all
    @header_menu = Menu.menu_list_by_menu_type(Menu::MENU_TYPE[:top_header])
    @comments = Comment.all
  end

  def show
    @post = Post.friendly.find(params[:id])
    #@related_posts = Post.where(:category_id => @post.category.id, :is_published => true)
    @categories = Category.all
    @header_menu = Menu.menu_list_by_menu_type(Menu::MENU_TYPE[:top_header])
    @comments = Comment.all
  end

  def post_by_category
    category = Category.friendly.find(params[:category])
    @posts = Post.where(:category_id => category.id, :is_published => true).order('id DESC')

    @categories = Category.all
    @header_menu = Menu.menu_list_by_menu_type(Menu::MENU_TYPE[:top_header])
    @comments = Comment.all
  end
end

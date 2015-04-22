class PostsController < ApplicationController
  include ActionView::Helpers::SanitizeHelper

  def index
    if params[:tag]
      @posts = Post.published_posts.tagged_with(params[:tag])
    else
      @posts = Post.published_posts
    end

    @categories = Category.all
    @header_menu = Menu.menu_list_by_menu_type(Menu::MENU_TYPE[:top_header])
    @comments = Comment.all

    inline_page_seo
  end

  def show
    @post = Post.friendly.find(params[:id])
    #@related_posts = Post.where(:category_id => @post.category.id, :is_published => true)
    @categories = Category.all
    @header_menu = Menu.menu_list_by_menu_type(Menu::MENU_TYPE[:top_header])
    @comments = Comment.all

    @page_title = @post.page_title.present? ? @post.page_title : @post.title
    @meta_keyword = @post.meta_keyword.present? ? @post.meta_keyword : @post.tag_list.map { |t| t}.join(', ')
    @meta_description = @post.meta_description.present? ? @post.meta_description : @post.title
  end

  def post_by_category
    category = Category.friendly.find(params[:category])
    @posts = Post.where(:category_id => category.id, :is_published => true).order('id DESC')

    @categories = Category.all
    @header_menu = Menu.menu_list_by_menu_type(Menu::MENU_TYPE[:top_header])
    @comments = Comment.all

    inline_page_seo
  end

  def blog_api
    @posts = Post.all

    render :json => @posts.map { |post| {
                id: post.id,
                title: post.title,
                post_link: post_url(post),
                category: post.category.try(:name),
                tags: post.tag_list.map { |t| t }.join(', '),
                description: strip_tags(post.body.truncate(1000, :separator => ' ')),
                feature_image: request.protocol + request.host_with_port  + post.feature_image_url(:main),
                created_date: post.created_at
              }
            }
  end
end

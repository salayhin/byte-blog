class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def initialize
    @categories = Category.all
    @header_menu = Menu.menu_list_by_menu_type(Menu::MENU_TYPE[:top_header])
  end

  def inline_page_seo
    page_title = BlogConfiguration.find_by_key(BlogConfiguration::KEY[:page_title])
    meta_keyword = BlogConfiguration.find_by_key(BlogConfiguration::KEY[:meta_keyword])
    meta_description = BlogConfiguration.find_by_key(BlogConfiguration::KEY[:meta_description])

    @page_title = (page_title.present? && page_title.value.present?) ? page_title.value : ''
    @meta_keyword = (meta_keyword.present? && meta_keyword.value.present?) ? meta_keyword.value : ActsAsTaggableOn::Tag.all.map { |t| t.name}.join(', ')
    @meta_description = (meta_description.present? && meta_description.value.present?) ? meta_description.value : ''
  end

  def authenticate_admin_user!
    redirect_to new_user_session_path unless current_user.try(:is_admin?)
  end
end

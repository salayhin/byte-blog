class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # def initialize
  #   @categories = Category.all
  #   @header_menu = Menu.menu_list_by_menu_type(Menu::MENU_TYPE[:top_header])
  #   @comments = Comment.all
  # end
end

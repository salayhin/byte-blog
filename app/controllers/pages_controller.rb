class PagesController < ApplicationController
  def about_us
    @categories = Category.all
    @header_menu = Menu.menu_list_by_menu_type(Menu::MENU_TYPE[:top_header])
    @comments = Comment.all
  end

  def contact_us
    @categories = Category.all
    @header_menu = Menu.menu_list_by_menu_type(Menu::MENU_TYPE[:top_header])
    @comments = Comment.all
  end
end

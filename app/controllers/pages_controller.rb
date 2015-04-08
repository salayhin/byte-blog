class PagesController < ApplicationController
  def about_us
    @page = Page.find_by_slug(Page::PAGE_SLUG['about_us'])
    @categories = Category.all
    @header_menu = Menu.menu_list_by_menu_type(Menu::MENU_TYPE[:top_header])
    @comments = Comment.all

    inline_page_seo
  end

  def contact_us
    @contact = Contact.new
    @categories = Category.all
    @header_menu = Menu.menu_list_by_menu_type(Menu::MENU_TYPE[:top_header])
    @comments = Comment.all

    inline_page_seo
  end

  def contact_us_submit
    contact = Contact.new(contact_params)
    if contact.save
      redirect_to contact_us_path, :notice => 'Message Sent Successfully!'
    end
  end

  private
  def contact_params
    params.required(:contact).permit(:name, :email, :message)
  end
end

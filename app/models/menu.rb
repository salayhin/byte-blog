class Menu < ActiveRecord::Base
  validates_presence_of :menu_type
  validates_presence_of :title

  MENU_TYPE = {
      top_header: 'Top Header',
      bottom_footer: 'Bottom Footer'
  }

  ## Scope List
  scope :menu_list_by_menu_type, ->(menu_type) { where('menu_type = ?', menu_type).order('priority') }
end

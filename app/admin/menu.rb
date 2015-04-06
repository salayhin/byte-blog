ActiveAdmin.register Menu do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :title, :url, :priority, :menu_type
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if resource.something?
  #   permitted
  # end

  index do
    selectable_column
    column :title
    column 'Url' do |menu|
      url = menu.url.to_s
      link_to url, url
    end
    column :priority
    column :menu_type
    actions
  end

  show do
    attributes_table do
      row :title
      row 'Url' do |menu|
        url = menu.url.to_s
        link_to url, url
      end
      row :priority
      row :menu_type
    end
  end

  # Form for Menu
  form do |f|
    f.inputs 'Menu' do
      f.input :title
      f.input :url
      f.input :priority
      f.input :menu_type, as: :select, collection: Menu::MENU_TYPE.map{ |menu| [menu.last, menu.last] }
      f.actions
    end
  end

  ####<$ Filter Options $>####
  filter :title, as: :string
  filter :url, as: :string

end

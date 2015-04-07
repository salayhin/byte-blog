ActiveAdmin.register Page do


  #menu false

  permit_params :name, :content

  index do
    selectable_column
    column auto_link :name
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :name
      row 'Content' do |page|
        page.content.html_safe
      end
    end
  end

  # Product Form
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :name
      f.input :content, as: :ckeditor, input_html: { palceholder: 'Content' }
      f.actions
    end
  end

  controller do
    defaults finder: :find_by_slug
  end

  ####<$ filter options $>####
  filter :name, as: :string

end

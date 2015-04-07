ActiveAdmin.register Contact do



  #menu false

  permit_params :name, :email, :message

  index do
    selectable_column
    column auto_link :name
    column auto_link :email
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :name
      row :email
      row :message
    end
  end

  # Product Form
  # form :html => { :enctype => "multipart/form-data" } do |f|
  #   f.semantic_errors *f.object.errors.keys
  #   f.inputs do
  #     f.input :name
  #     f.input :email
  #     f.input :email
  #     f.input :content, as: :ckeditor, input_html: { palceholder: 'Content' }
  #     f.actions
  #   end
  # end


  ####<$ filter options $>####
  filter :name, as: :string
  filter :email, as: :string



end

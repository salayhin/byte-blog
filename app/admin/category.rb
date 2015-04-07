ActiveAdmin.register Category do


  #menu false

  permit_params :name, :slug

  index do
    selectable_column
    column auto_link :name
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :name
      row :created_at
    end
  end

  # Product Form
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :name
      f.actions
    end
  end


  ####<$ filter options $>####
  filter :name, as: :string

end

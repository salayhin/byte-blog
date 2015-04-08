ActiveAdmin.register BlogConfiguration do

  menu false

  permit_params :key, :value

  index do
    selectable_column
    column auto_link :key
    column auto_link :value
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :key
      row :value
    end
  end

  # Configuration Form
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :key
      f.input :value
      f.actions
    end
  end

  ####<$ filter options $>####
  filter :key, as: :string

end

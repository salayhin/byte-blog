ActiveAdmin.register Post do

  #menu false

  ####<$ Scope List $>####
  scope :all, :default => true

  scope :pending do |posts|
    posts.where('is_published =?', false)
  end

  scope :published do |posts|
    posts.where('is_published  =?', true)
  end

  permit_params :title, :body, :feature_image, :tag_list, :category_id, :is_published, :page_title, :meta_keyword, :meta_description

  after_build do |post|
    post.admin_user = current_admin_user
  end

  index do
    selectable_column
    # column do |post|
    #   image_tag(post.feature_image_url(:list)) if post.feature_image.present?
    # end
    column auto_link :title
    column :category
    column :is_published
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :name
      row :category
      row 'Created By' do |post|
        post.admin_user.try(:email)
      end
      row 'Body' do |post|
        post.body.html_safe
      end
      row 'Tags' do |post|
        #post.tag_list.map { |t| link_to t, tag_path(t) }.join(', ')
        post.tag_list.map { |t| t }.join(', ')
      end
      row :is_published
      row :page_title
      row :meta_keyword
      row :meta_description
      row 'Feature Image' do |post|
        image_tag(post.feature_image_url(:list)) if post.feature_image.present?
      end
    end
  end

  # Product Form
  form :html => { :enctype => "multipart/form-data" } do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs do
      f.input :title
      f.input :body, as: :ckeditor, input_html: { palceholder: 'Content' }
      f.input :category
      f.input :tag_list
      f.input :is_published
      f.input :page_title
      f.input :meta_keyword
      f.input :meta_description
      f.input :feature_image, as: :file, :hint => image_tag(f.object.feature_image.url(:list))
      f.actions
    end
  end

  sidebar :post_stats, :only => :show do
    attributes_table_for resource do
      row('Total Post')  { Post.all.count }
    end
  end

  # sidebar :recent_orders, :only => :show do
  #   Order.find_with_product(resource).limit(5).collect do |order|
  #     auto_link(order)
  #   end.join(content_tag('br')).html_safe
  # end

  ####<$ filter options $>####
  filter :title, as: :string
  filter :category
  filter :is_published, as: :radio

  controller do
    defaults finder: :find_by_slug
  end

end

class AddSeoFieldsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :page_title, :string
    add_column :posts, :meta_keyword, :string
    add_column :posts, :meta_description, :string
  end
end

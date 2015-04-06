class AddColumnsToComments < ActiveRecord::Migration
  def change
    add_column :comments, :email, :string
    add_column :comments, :is_published, :boolean, :default => false
  end
end

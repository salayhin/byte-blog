class CreateBlogConfigurations < ActiveRecord::Migration
  def change
    create_table :blog_configurations do |t|
      t.string :key
      t.text :value

      t.timestamps null: false
    end
  end
end

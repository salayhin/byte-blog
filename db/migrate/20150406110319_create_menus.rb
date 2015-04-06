class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :title
      t.string :url
      t.string :menu_type
      t.integer :priority

      t.timestamps null: false
    end
  end
end

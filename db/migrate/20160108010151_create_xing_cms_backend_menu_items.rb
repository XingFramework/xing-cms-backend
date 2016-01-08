class CreateXingCmsBackendMenuItems < ActiveRecord::Migration
  def change
    create_table :xing_cms_backend_menu_items do |t|
      t.string :name
      t.string :path
      t.integer :parent_id
      t.integer :lft
      t.integer :rgt
      t.integer :page_id

      t.timestamps null: false
    end
  end
end

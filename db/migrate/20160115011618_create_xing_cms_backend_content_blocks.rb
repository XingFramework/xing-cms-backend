class CreateXingCmsBackendContentBlocks < ActiveRecord::Migration
  def change
    create_table :xing_cms_backend_content_blocks do |t|
      t.string :content_type
      t.text :body

      t.timestamps null: false
    end
  end
end

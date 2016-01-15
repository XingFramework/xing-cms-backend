class CreateXingCmsBackendPageContents < ActiveRecord::Migration
  def change
    create_table :xing_cms_backend_page_contents do |t|
      t.integer :page_id
      t.integer :content_block_id
      t.string :name

      t.timestamps null: false
    end

	  add_index(:xing_cms_backend_page_contents, :content_block_id, {name: "index_page_contents_on_content_block_id", using: :btree})
	  add_index(:xing_cms_backend_page_contents, :page_id, {name: "index_page_contents_on_page_id", using: :btree})
  end
end

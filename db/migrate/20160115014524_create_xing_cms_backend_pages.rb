class CreateXingCmsBackendPages < ActiveRecord::Migration
  enable_extension "hstore"

  def change
    create_table :xing_cms_backend_pages do |t|
      t.string :title
      t.boolean :published, default: true, null: false
      t.text :keywords
      t.text :description
      t.datetime :edited_at
      t.string :type
      t.datetime :publish_start
      t.datetime :publish_end
      t.hstore :metadata
      t.string :url_slug
      t.datetime :publication_date

      t.timestamps null: false
    end

	  add_index(:xing_cms_backend_pages, :url_slug, {name: "index_pages_on_url_slug", using: :btree})
  end
end

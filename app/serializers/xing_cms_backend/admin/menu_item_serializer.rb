module XingCmsBackend
  class Admin::MenuItemSerializer < Xing::Serializers::Base
    attributes :type, :name, :path, :page, :parent_id


    def filter(keys)
      if object.page.present?
        keys - [ :path ]
      else
        keys - [ :page ]
      end
    end

    def path
      object.path
    end

    def page
       if object.page
         { links: { self: engine_routes.page_path(object.page) }}
       end
    end

    def type
       object.page ? 'page' : 'raw_url'
    end

    def links
      { :self => engine_routes.admin_menu_item_path(object)  }
    end

    #TODO: Move this to where all engine serializers can use
    def engine_routes
      XingCmsBackend::Engine.routes.url_helpers
    end
  end
end

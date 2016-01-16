module XingCmsBackend
  class Admin::PageSerializer < PageSerializer
    attributes :url_slug, :published, :publish_start, :publish_end

    def links
      { :self => engine_routes.admin_page_path(:url_slug => object.url_slug),
        :public => engine_routes.page_path(:url_slug => object.url_slug),
        :admin => engine_routes.admin_page_path(:url_slug => object.url_slug) }
    end

    #TODO: Move this to where all engine serializers can use
    def engine_routes
      XingCmsBackend::Engine.routes.url_helpers
    end
  end
end

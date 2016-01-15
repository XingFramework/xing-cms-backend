require 'xing-backend'

module XingCmsBackend
  class ContentBlockSerializer < Xing::Serializers::Base
    attributes :content_type, :body

    def links
      { :self => engine_routes.admin_content_block_path(object) }
    end

    #TODO: Move this to where all engine serializers can use
    def engine_routes
      XingCmsBackend::Engine.routes.url_helpers
    end
  end
end

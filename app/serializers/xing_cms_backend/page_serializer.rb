require 'xing-backend'

module XingCmsBackend
  class PageSerializer < Xing::Serializers::Base
    attributes :title, :keywords, :description, :layout#, :contents

    #def contents
      #hash = {}
      #object.contents.each do |k,v|
        #hash[k] = ContentBlockSerializer.new(v).as_json
      #end
      #hash
    #end

    def links
      { :self => engine_routes.page_path(object), :admin => engine_routes.admin_page_path(object), :public => engine_routes.page_path(object)  }
    end

    #TODO: Move this to where all engine serializers can use
    def engine_routes
      XingCmsBackend::Engine.routes.url_helpers
    end
  end
end

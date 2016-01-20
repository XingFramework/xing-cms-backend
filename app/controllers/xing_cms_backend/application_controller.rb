module XingCmsBackend

  #TODO: Should extend from Xing::Controllers::Base.
  # See below
  #class ApplicationController < Xing::Controllers::Base
  class ApplicationController < ActionController::Base

    #TODO add cancancan instead of checking this in admin controller
    def current_user
      true
    end


    ###########################################################################
    #TODO: This shouldn't be here. Should extend from Xing::Controllers::Base.
    # Getting error: uninitialized constant Concerns::SetUserByToken when
    # extending from Xing::Controllers::Base and when running specs.

    respond_to :json

    protect_from_forgery
    before_filter :check_format

    def check_format
      if request.subdomains.include? Xing.backend_subdomain
        if request.headers["Accept"] =~ /json/
          params[:format] = :json
        else
          render :nothing => true, :status => 406
        end
      end
    end

    def json_body
      @json_body ||= request.body.read
    end

    def parse_json
      @parsed_json ||= JSON.parse(json_body)
    end

    def failed_to_process(error_document)
      render :status => 422, :json => error_document
    end

    def successful_create(new_resource_path)
      render :status => 201, :json => {}, :location => new_resource_path
    end

    ###########################################################################
  end
end

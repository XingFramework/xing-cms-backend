module XingCmsBackend
  class ApplicationController < ActionController::Base
    #TODO add cancancan instead of checking this in admin controller
    def current_user
      true
    end
  end
end

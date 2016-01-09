require 'spec_helper'

module XingCmsBackend
  describe Admin::AdminController, :type => :controller do
    let :user do
      double("admin user")
    end

    it "should reject if not logged in as admin" do
      expect(controller.reject_if_not_logged_in).to equal("yup")
    end
  end
end

require 'spec_helper'

# example JSON output from request
# {"links"=>{
#    "self" => "pages/auto_gen_link_url_2",
#    "admin" => "admin/pages/auto_gen_link_url_2" },
#  "data"=>
#   {"title"=>"Title for page 2",
#    "keywords"=>nil,
#    "description"=>nil,
#    "layout"=>""
#    "published" => "true",
#    "publish_start" => nil,
#    "publish_end" => nil,
#    "contents"=>
#     {"styles"=>
#       {"links"=>{"self"=>"/admin/content_blocks/6"},
#        "data"=>{"content_type"=>"text/css", "body"=>"uncleaned"}},
#      "headline"=>
#       {"links"=>{"self"=>"/admin/content_blocks/5"},
#        "data"=>{"content_type"=>"text/html", "body"=>"the content"}},
#      "main"=>
#       {"links"=>{"self"=>"/admin/content_blocks/4"},
#        "data"=>{"content_type"=>"text/html", "body"=>"foo bar"}}}}}

module XingCmsBackend
  describe "admin/pages#show", :type => :request do
    let :main     do FactoryGirl.create(:content_block) end
    let :headline do FactoryGirl.create(:content_block, :body => 'the content') end
    let :styles   do FactoryGirl.create(:content_block, :content_type => 'text/css', :body => "more stuff") end

    let :page do
      FactoryGirl.create(:page,
        :page_contents => [  PageContent.new(:name => 'main', :content_block => main),
                             PageContent.new(:name => 'headline', :content_block => headline),
                             PageContent.new(:name => 'styles', :content_block => styles)]
      )
    end

    #let :admin do FactoryGirl.create(:admin) end

    describe "GET admin/pages/:url_slug" do
      it "shows page as json" do
        #authenticated_json_get admin, "admin/pages/#{page.url_slug}"
        json_get "/xing_cms_backend/admin/pages/#{page.url_slug}"

        expect(response).to be_success
        expect(response.body).to have_json_path("links")
        expect(response.body).to have_json_path("links/self")
        expect(response.body).to have_json_path("links/public")
        expect(response.body).to have_json_path("data")
        expect(response.body).to have_json_path("data/title")
        expect(response.body).to have_json_path("data/keywords")
        expect(response.body).to have_json_path("data/description")
        expect(response.body).to have_json_path("data/layout")
        expect(response.body).to have_json_path("data/contents")
        expect(response.body).to have_json_size(3).at_path("data/contents")
        expect(response.body).to be_json_eql("\"/xing_cms_backend/admin/pages/#{page.url_slug}\"").at_path("links/self")
        expect(response.body).to be_json_eql("\"#{page.title}\"").at_path("data/title")
        expect(response.body).to be_json_eql("\"#{engine_routes.admin_content_block_path(headline)}\"").at_path("data/contents/headline/links/self")
        expect(response.body).to be_json_eql("\"#{styles.body}\"").at_path("data/contents/styles/data/body")
      end
    end

    # TODO: Still need to bring in authentication
    describe "not authenticated", :skip => true do
      it "should return not authorized" do
        json_put "admin/pages/#{page.url_slug}"
        expect(response.status).to be(401)
      end
    end
  end
end

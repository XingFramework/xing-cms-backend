require 'spec_helper'

module XingCmsBackend
  describe MenuItem, :skip => true do
    describe "mass assignment" do
       it "should mass assign name and path" do
         location = MenuItem.new(:name => 'foo', :path => 'bar' )
         expect(location.name).to eq('foo')
         expect(location.path).to eq('bar')
       end
     end

     # describe "validations" do
     #   describe "presence" do
     #     it "should not create a location with blank name" do
     #       expect(FactoryGirl.build(:location, :name => nil)).not_to be_valid
     #     end
     #    it "should allow alocation with a name" do
     #      expect(FactoryGirl.build(:location, :name => 'foo')).to be_valid
     #    end
     #   end
     # end

     # describe "resolved path" do
     #   it "should return the page permalink if there's a page foreign key" do
     #     page = FactoryGirl.build(:page, :permalink => 'some/address')
     #     loc = FactoryGirl.build(:location, :path => 'foobar')
     #     loc.page = page
     #     loc.save!
     #     expect(loc.resolved_path).to eq("/" + page.permalink)
     #   end

     #   it "should return the location's path if there's no page foreign key" do
     #     loc = FactoryGirl.build(:location, :path => 'foobar')
     #     expect(loc.resolved_path).to eq("/" + 'foobar')
     #   end
     # end
  end
end

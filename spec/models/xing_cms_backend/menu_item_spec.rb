require 'spec_helper'

module XingCmsBackend
  describe MenuItem do
    describe "mass assignment" do
      it "should mass assign name and path" do
        menu_item = MenuItem.new(:name => 'foo', :path => 'bar' )
        expect(menu_item.name).to eq('foo')
        expect(menu_item.path).to eq('bar')
      end
    end

    describe "validations" do
      describe "presence" do
        it "should not create a menu item  with blank name" do
          expect(FactoryGirl.build(:menu_item, :name => nil)).not_to be_valid
        end
        it "should allow a menu item  with a name" do
          expect(FactoryGirl.build(:menu_item, :name => 'foo')).to be_valid
        end
      end
    end

    describe "associations" do
      it "should set up proper associations" do
        expect(MenuItem.reflect_on_association(:parent).macro).to eq(:belongs_to)
        expect(MenuItem.reflect_on_association(:page).macro).to eq(:belongs_to)
      end
    end
  end
end

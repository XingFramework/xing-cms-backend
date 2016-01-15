# == Schema Information
#
# Table name: page_contents
#
#  id               :integer          not null, primary key
#  page_id          :integer
#  content_block_id :integer
#  name             :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#

module XingCmsBackend
  class PageContent < ActiveRecord::Base
    #belongs_to :page
    belongs_to :content_block
  end
end

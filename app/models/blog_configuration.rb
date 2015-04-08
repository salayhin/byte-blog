class BlogConfiguration < ActiveRecord::Base

  validates_uniqueness_of :key

  KEY = {
      :page_title => 'page_title',
      :meta_keyword => 'meta_keyword',
      :meta_description => 'meta_description',
  }
end

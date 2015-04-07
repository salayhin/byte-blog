class Page < ActiveRecord::Base
  extend FriendlyId

  validates_presence_of :name
  validates_presence_of :content

  friendly_id :name, use: [:slugged, :history]

  PAGE_SLUG = {
      :about_us => 'about-us'
  }
end

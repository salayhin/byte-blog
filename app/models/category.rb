class Category < ActiveRecord::Base
  extend FriendlyId

  has_many :posts

  validate :name

  friendly_id :name, use: [:slugged, :history]
end

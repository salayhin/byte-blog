class Post < ActiveRecord::Base
  require 'carrierwave/orm/activerecord'

  belongs_to :category
  acts_as_taggable

  # Post's logo uploader
  mount_uploader :feature_image, FetureImageUploader

  validate :title
  validate :body
end

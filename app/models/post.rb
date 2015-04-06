class Post < ActiveRecord::Base
  require 'carrierwave/orm/activerecord'

  # Post's logo uploader
  mount_uploader :feature_image, FetureImageUploader

  validate :title
  validate :body
end

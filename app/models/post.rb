class Post < ActiveRecord::Base
  extend FriendlyId

  require 'carrierwave/orm/activerecord'

  belongs_to :category
  has_many :comments
  acts_as_taggable

  # Post's logo uploader
  mount_uploader :feature_image, FetureImageUploader

  validates_presence_of :title
  validates_presence_of :body

  scope :published_posts, -> { where(is_published: true).order('id DESC') }

  friendly_id :title, use: [:slugged, :history]
end

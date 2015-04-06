class Category < ActiveRecord::Base
  has_many :posts

  validate :name
end

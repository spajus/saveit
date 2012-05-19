class Bookmark < ActiveRecord::Base
  attr_accessible :title, :url, :visited
  belongs_to :user
end

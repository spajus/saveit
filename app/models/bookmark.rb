class Bookmark < ActiveRecord::Base
  attr_accessible :title, :url, :visited
  belongs_to :user
  validates_presence_of :url
  default_scope :order => "created_at desc"

end

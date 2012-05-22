class Bookmark < ActiveRecord::Base
  attr_accessible :title, :url, :visited
  belongs_to :user
  validates_presence_of :url
  default_scope :order => "created_at desc"
  after_initialize :default_values

  protected

  def default_values
    self.visited ||= false
  end

end

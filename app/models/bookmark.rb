class Bookmark < ActiveRecord::Base
  attr_accessible :title, :url, :visited
  belongs_to :user

  validates_presence_of :url
  validates :url, uniqueness: { scope: :user_id }

  after_initialize :default_values

  default_scope order: "created_at desc"
  scope :visited,   conditions: { visited: true }
  scope :unvisited, conditions: { visited: false }


  acts_as_taggable

  protected

  def default_values
    self.visited ||= false
  end

end

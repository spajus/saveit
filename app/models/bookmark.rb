class Bookmark < ActiveRecord::Base
  attr_accessible :title, :url, :visited, :tag_names
  attr_accessor :tag_names

  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates_presence_of :url
  validates :url, uniqueness: { scope: :user_id }

  after_initialize :default_values
  after_save :assign_tags

  default_scope order: "created_at desc"
  scope :visited,   conditions: { visited: true }
  scope :unvisited, conditions: { visited: false }

  acts_as_api

  api_accessible :default do |t|
    t.add :id
    t.add :url
    t.add :title
    t.add :visited
    t.add :tag_names
    t.add :created_at
  end

  def tag_names
    self.tags.collect(&:name)
  end

  protected

  def default_values
    self.visited ||= false
  end


  def assign_tags
    if @tag_names
      tags = []
      @tag_names.each do |t|
        tags.push(Tag.create_or_find(self.user, t))
      end
      self.tags = tags
    end
  end

end

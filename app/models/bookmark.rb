class Bookmark < ActiveRecord::Base
  attr_accessible :title, :url, :visited

  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates_presence_of :url
  validates :url, uniqueness: { scope: :user_id }

  after_initialize :default_values

  default_scope order: "created_at desc"
  scope :visited,   conditions: { visited: true }
  scope :unvisited, conditions: { visited: false }

  def add_tag(tag_name)
    begin
      t = nil
      transaction do
        t = Tag.create_or_find(self.user, tag_name)
        taggings.create(tag: t)
      end
      t
    rescue
      return nil
    end
  end

  def remove_tag(tag_name)
    begin
      tagging = self.taggings.with_tag(tag_name).first
      tagging.destroy
      reload
    rescue
      return false
    end
  end


  def tag_names
    tags.collect(&:name)
  end


  protected

  def default_values
    self.visited ||= false
  end

end

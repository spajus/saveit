class Tagging < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :bookmark, :tag, :bookmark_id, :tag_id

  validates :bookmark_id, uniqueness: { scope: :tag_id }

  belongs_to :bookmark
  belongs_to :tag

  def self.with_tag(tag_name)
    find(:all, joins: :tag, conditions: { tags: {name: tag_name} })
  end
end

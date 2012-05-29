class Tagging < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :bookmark, :tag, :bookmark_id, :tag_id
  attr_protected :tag_name

  validates :bookmark_id, uniqueness: { scope: :tag_id }

  belongs_to :bookmark
  belongs_to :tag

  acts_as_api

  api_accessible :default do |t|
    t.add :id
    t.add :tag_id
    t.add :bookmark_id
  end

  api_accessible :with_tag_name, extend: :default do |t|
    t.add lambda{|tagging| tagging.tag.name }, as: :tag_name
  end

  def self.with_tag(tag_name)
    find(:all, joins: :tag, conditions: { tags: {name: tag_name} })
  end
end

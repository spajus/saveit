class Tag < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :name, :user

  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :bookmarks, through: :taggings

  validates :name, uniqueness: { scope: :user_id }

  default_scope order: "created_at desc"

  acts_as_api

  api_accessible :default do |t|
    t.add :id
    t.add :name
  end

  api_accessible :with_bookmarks, extend: :default do |t|
    t.add :bookmarks, template: :default
  end

  api_accessible :with_bookmarks_count, extend: :default do |t|
    t.add :bookmarks_count, as: :bookmarks
  end

  def self.create_or_find(owner, tag_name)
    return nil if owner.nil?

    where( name: tag_name, user_id: owner.id).first || create(name: tag_name, user: owner)
  end

  def add_bookmark(bookmark)
    taggings.create(bookmark: bookmark)
  end

  def remove_bookmark(bookmark)
    taggings.find(bookmark: bookmark).first.destroy rescue return false
  end

  def bookmarks_count
    { count: bookmarks.count }
  end

  def to_s
    name
  end

  def to_param
    name.parameterize()
  end


end

class Tag < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :name, :user

  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :bookmarks, through: :taggings

  validates :name, uniqueness: { scope: :user_id }


  def self.create_or_find(owner, tag_name)
    return nil if owner.nil?

    where( name: tag_name, user_id: owner.id).first || create(name: tag_name, user: owner)
  end


  def add_bookmark(bookmark)
      taggings.create(bookmark: bookmark)
  end

  def remove_bookmark(bookmark)
    taggings.find(:first, bookmark: bookmark).destroy rescue return false
  end


  def to_s
    name
  end

  def to_param
    name.parametrize
  end

  def as_json(options={})
    {
      id: id,
      name: name,
      bookmarks: {
        count: bookmarks.count
      }
    }
  end
end

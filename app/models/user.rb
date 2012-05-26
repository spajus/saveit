class User < ActiveRecord::Base
  attr_accessible :email, :name, :provider, :uid

  has_many :bookmarks
  has_many :settings

  has_many :taggings, through: :bookmarks
  has_many :tags

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
    end
  end
end

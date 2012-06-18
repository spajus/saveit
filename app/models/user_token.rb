class UserToken < ActiveRecord::Base
  attr_accessible :provider, :uid, :created_at
  belongs_to :user
end
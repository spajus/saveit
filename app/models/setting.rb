class Setting < ActiveRecord::Base
  attr_accessible :key, :value
  belongs_to :user
  validates :key, uniqueness: { scope: :user_id }, inclusion: {
    in: %w( linkTarget confirmDelete useTags )
  }
end

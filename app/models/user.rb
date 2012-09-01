class User < ActiveRecord::Base

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :trackable, :omniauthable, :rememberable

  attr_accessible :email, :password, :password_confirmation, :name, :image, :provider, :uid

  validates_uniqueness_of :email

  has_many :bookmarks
  has_many :settings
  has_many :user_tokens

  has_many :taggings, through: :bookmarks
  has_many :tags

  def apply_omniauth(omniauth)
    self.confirmed_at = Date.current()
    user_tokens.build(provider: omniauth['provider'], uid: omniauth[:uid])
    self.name = omniauth[:info][:name]
    if omniauth[:info][:image]
      self.image = omniauth[:info][:image]
    end
  end

  def password_required?
    (user_tokens.empty? || !password.blank?) && super
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session[:omniauth]
        user.user_tokens.build(provider: data['provider'], uid: data['uid'])
      end
    end
  end
end

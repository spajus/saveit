class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :backbone_settings, :avatar_url

  protected

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def backbone_settings
    { 'full_bookmarklet_url' => url_for(:controller => 'home',
                                          :action => 'bookmarklet') }
  end

  def avatar_url(user)
    default_url = "#{root_url}images/guest.png"
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=#{CGI.escape(default_url)}"
  end
end

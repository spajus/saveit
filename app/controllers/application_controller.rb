class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :backbone_settings

  protected

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def backbone_settings
    { 'full_bookmarklet_url' => url_for(:controller => 'home',
                                          :action => 'bookmarklet') }
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  before_filter :backbone_settings

  protected

  def create_bookmark(url, title)
    bookmark = current_user.bookmarks.where(url: url).first
    unless bookmark
      bookmark = current_user.bookmarks.create url: url, title: title
    end
    bookmark
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def backbone_settings
    bookmarklet_js = render_to_string partial: "bookmarklet.js"
    gon.bookmarklet_js = bookmarklet_js.gsub(/\s*\n+\s*/, '').gsub(/\s*(,|\{|\}|;)\s*/, "\\1")

  end

end

class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :current_bookmarks
  before_filter :backbone_settings

  protected

  def create_bookmark(url, title)
    bookmark = current_user.bookmarks.where(url: url).first
    unless bookmark
      bookmark = current_user.bookmarks.create url: url, title: title
    end
    bookmark
  end

  def require_user
    return true if current_user

    respond_to do |format|
      format.html { redirect_to '/' }
      format.json { render json: {error:'authentication required'}, status: 403 }
    end
    false
  end

  def current_user
    @current_user ||= User.find(cookies.signed[:user_id]) if cookies.signed[:user_id]
  end

  def current_bookmarks
    current_user.bookmarks
  end

  def backbone_settings
    bookmarklet_js = render_to_string partial: "bookmarklet", formats: [:js]
    gon.bookmarklet_js = bookmarklet_js.gsub(/\s*\n+\s*/, '').gsub(/\s*(,|\{|\}|;)\s*/, "\\1")

  end

end

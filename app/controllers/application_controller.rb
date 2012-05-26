class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :current_bookmarks
  before_filter :backbone_settings

  protected

  def create_bookmark(url, title)
    current_bookmarks.where(url: url).first || current_bookmarks.create(url: url, title: title)
  end

  def require_user
    return true if current_user

    respond_to do |format|
      format.html { redirect_to '/' }
      format.json { render json: {error:'forbidden'}, status: 403 }
    end
    false
  end

  def current_user
    @current_user ||= User.find(cookies.signed[:user_id]) if cookies.signed[:user_id]
  end

  def current_bookmarks
    current_user.bookmarks
  end

  def current_settings
    current_user.settings
  end

  def current_tags
    current_user.tags
  end

  def backbone_settings
    bookmarklet_js = render_to_string partial: "bookmarklet", formats: [:js]
    gon.bookmarklet_js = bookmarklet_js.gsub(/\s*\n+\s*/, '').gsub(/\s*(,|\{|\}|;)\s*/, "\\1")
    if current_user
      gon.user_settings = current_settings
    end
  end

  def respond_404(msg)
    render json: {error: msg}, status: 404
  end

end

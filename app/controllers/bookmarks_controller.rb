class BookmarksController < ApplicationController
  respond_to :json
  def index
    if session[:user_uid]
      respond_with Bookmark.find_all_by_user_uid(session[:user_uid])
  end
end

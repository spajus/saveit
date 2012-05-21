class HomeController < ApplicationController
  def index
  end

  def bookmarklet
    @bookmark = current_user.bookmarks.create title: params[:t], url: params[:b]
    render :layout => false, :content_type => 'text/javascript', :formats => [:js]
  end
end

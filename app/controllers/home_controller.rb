class HomeController < ApplicationController

  def index
    render content_type: 'text/html'
  end

  def bookmarklet
    if current_user
      @bookmark = current_user.bookmarks.create title: params[:t], url: params[:b]
    else
      # Javascript assigns window.location to home page, where user can log in.
      # After login user is redirected back to target url
      flash[:message] = """Please sign in to use the bookmarklet.
You will be redirected back to <a href=\"#{params[:b]}\">#{params[:t]}</a>
afterwards.""".html_safe
      session[:save_and_return_to] = { :title => params[:t], :url => params[:b]}
    end

    render :layout => false, :content_type => 'text/javascript', :formats => [:js]
  end
end

require 'rest_client'

class HomeController < ApplicationController

  def index
    if current_user
      gon.bookmarks = current_bookmarks
        .page(1)
        .per(current_page_size)
        .as_api_response(:default)
    end
    render content_type: 'text/html'
  end

  def bookmarklet
    url = params[:b]
    title = params[:t] or url

    if current_user
      @bookmark = create_bookmark(url, title)
    else
      _session_flash(url, title)
    end

    render :layout => false, :content_type => 'text/javascript', :formats => [:js]
  end

  def preview
    data = RestClient.get "http://img.bitpixels.com/getthumbnail?code=73310&size=200&url=#{params[:url]}"
    response.headers['Content-Type'] = 'image/jpeg'
    render stream: true, text: data
  end


  def snapshot
    kit = IMGKit.new params[:url]
    img = kit.to_img
    response.headers['Content-Type'] = 'image/jpeg'
    render stream: true, text: img
  end

  def bookmarklet_failover

    url = params[:b]

    if current_user
      @bookmark = create_bookmark(url, url)
      redirect_to url
    else
      _session_flash(url, url)
      redirect_to action: "index"
    end

  end

  def opensearch
    render layout: false, content_type: 'text/xml', formats: [:xml]
  end

  private

  def _session_flash(url, title)
    # Javascript assigns window.location to home page, where user can log in.
    # After login user is redirected back to target url
    flash[:message] = """Please sign in to use the bookmarklet.
You will be redirected back to <a href=\"#{url}\">#{title}</a>
afterwards.""".html_safe
    session[:save_and_return_to] = { title: title, url: url}
  end

end

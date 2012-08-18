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
    unless current_user
      redirect_to "http://google.com"
    end
    snap = Snapshot.find_by_url params[:url]
    if snap
      redirect_to snap.image.url(:thumb)
    else
      Snapshot.delay.take params[:url]
      redirect_to "/images/thumb/missing.png"
    end
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

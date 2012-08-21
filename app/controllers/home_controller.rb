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
    description = params[:d]

    if current_user
      @bookmark = create_bookmark(url, title, description)
    else
      _session_flash(url, title, description)
    end

    render :layout => false, :content_type => 'text/javascript', :formats => [:js]
  end

  def preview
    unless current_user
      redirect_to "http://google.com"
      return
    end
    snap = Snapshot.find_by_url params[:url]
    unless snap or snap.image.url(:thumb).match "/missing"
      snap = Snapshot.take params[:url]
    end
    redirect_to snap.image.url(:thumb)
  end

  def test_snapping
    snap = Snapshot.find_by_url params[:url]
    unless snap
      snap = Snapshot.take(params[:url])
    end
    render text: snap.image.url(:thumb)
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

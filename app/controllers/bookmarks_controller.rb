class BookmarksController < ApplicationController
  before_filter :require_user
  respond_to :json

  def index
    respond_with current_bookmarks
  end

  def filter
    case params[:type]
      when 'visited'
        respond_with current_bookmarks.visited
      when 'unvisited'
        respond_with current_bookmarks.unvisited
      else
        raise "Unsupported bookmark type: #{params[:type]}"
    end
  end

  def show
    respond_with current_bookmarks.find(params[:id])
  end

  def create
    respond_with current_bookmarks.create(params[:bookmark])
  end

  def update
    respond_with current_bookmarks.update(params[:id], params[:bookmark])
  end

  def destroy
    respond_with current_bookmarks.destroy(params[:id])
  end


  def tags
    bookmark = current_bookmarks.find_by_id(params[:id])

    respond_404('Bookmark not found') and return unless bookmark

    respond_with bookmark.tags
  end

end

class TagsController < ApplicationController
  before_filter :require_user
  respond_to :json

  def index
    respond_with current_tags.to_json( include_bookmarks_count: true)
  end


  def create
    respond_with current_tags.create(params[:tag])
  end

  def update
    respond_with current_tags.update(params[:id], params[:tag])
  end

  def destroy
    respond_with current_tags.destroy(params[:id])
  end

  def add_bookmark
    tag      = current_tags.find_by_name(params[:tag_id])
    bookmark = current_bookmarks.find_by_id(params[:id])

    respond_404('Tag not found') and return unless tag
    respond_404('Bookmark not found') and return unless bookmark

    respond_with tag.add_bookmark(bookmark)
  end

  def remove_bookmark
    tag = current_tags.find_by_name(params[:tag_id])
    bookmark = current_bookmarks.find_by_id(params[:id])

    respond_404('Tag not found') and return unless tag
    respond_404('Bookmark not found') and return unless bookmark

    respond_with tag.remove_bookmark(bookmark)
  end

  def list_bookmarks
    tag = current_tags.find_by_name(params[:tag_id])

    respond_404('Tag not found') and return unless tag

    respond_with tag.bookmarks
  end

end

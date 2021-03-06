class BookmarksController < ApplicationController
  self.responder = ActsAsApi::Responder
  before_filter :require_user
  respond_to :json

  def index
    tag = params[:tag]
    query = params[:query]
    page = params[:page]
    count = params[:count]
    per_page = params[:per_page] or current_page_size

    bookmarks = current_bookmarks
      .tagged_with(tag)
      .query(query)

    if count
      return respond_with bookmarks.count
    end

    respond_with bookmarks.page(page).per(per_page), api_template: :default
  end

  def show
    respond_with current_bookmarks.find(params[:id]), api_template: :default
  end

  def create
    bookmark = current_bookmarks.create(params[:bookmark])
    Snapshot.delay.take(bookmark.url)
    respond_with bookmark, api_template: :default
  end

  def update
    params[:bookmark][:tag_names] = params.delete(:tag_names) if params.has_key? :tag_names
    respond_with current_bookmarks.update(params[:id], params[:bookmark]), api_template: :default
  end

  def destroy
    respond_with current_bookmarks.destroy(params[:id]), api_template: :default
  end

end

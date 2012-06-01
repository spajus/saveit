class BookmarksController < ApplicationController
  self.responder = ActsAsApi::Responder
  before_filter :require_user
  respond_to :json

  def index
    visited = params[:visited] == "true"
    tag = params[:tag]
    bookmarks = current_bookmarks.visited(visited).tagged_with(tag)
    respond_with bookmarks, api_template: :default
  end

  def show
    respond_with current_bookmarks.find(params[:id]), api_template: :default
  end

  def create
    respond_with current_bookmarks.create(params[:bookmark]), api_template: :default
  end

  def update
    params[:bookmark][:tag_names] = params.delete(:tag_names) if params.has_key? :tag_names
    respond_with current_bookmarks.update(params[:id], params[:bookmark]), api_template: :default
  end

  def destroy
    respond_with current_bookmarks.destroy(params[:id]), api_template: :default
  end

end

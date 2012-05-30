class BookmarksController < ApplicationController
  self.responder = ActsAsApi::Responder
  before_filter :require_user
  respond_to :json

  def index
    respond_with current_bookmarks, api_template: :default
  end

  def filter
    case params[:type]
      when 'visited'
        respond_with current_bookmarks.visited, api_template: :default
      when 'unvisited'
        respond_with current_bookmarks.unvisited, api_template: :default
      else
        raise "Unsupported bookmark type: #{params[:type]}"
    end
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

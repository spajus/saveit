class BookmarksController < ApplicationController
  self.responder = ActsAsApi::Responder

  before_filter :require_user
  respond_to :json

  def index
    respond_with current_bookmarks, api_template: :with_taggings
  end

  def filter
    case params[:type]
      when 'visited'
        respond_with current_bookmarks.visited, api_template: :with_taggings
      when 'unvisited'
        respond_with current_bookmarks.unvisited, api_template: :with_taggings
      else
        raise "Unsupported bookmark type: #{params[:type]}"
    end
  end

  def show
    respond_with current_bookmarks.find(params[:id]), api_template: :with_taggings
  end

  def create
    respond_with current_bookmarks.create(params[:bookmark])
  end

  def update
    if params[:bookmark].has_key? :taggings
      params[:bookmark][:taggings_attributes] = params[:bookmark].delete(:taggings)
    end

    respond_with current_bookmarks.update(params[:id], params[:bookmark]), api_template: :with_taggings
  end

  def destroy
    respond_with current_bookmarks.destroy(params[:id]), api_template: :with_taggings
  end

end

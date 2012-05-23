class BookmarksController < ApplicationController
  respond_to :json

  def index
    respond_with current_user.bookmarks
  end

  def show
    respond_with current_user.bookmarks.find(params[:id])
  end

  def create
    respond_with current_user.bookmarks.create(params[:bookmark])
  end

  def update
    respond_with current_user.bookmarks.update(params[:id], params[:bookmark])
  end

  def destroy
    respond_with current_user.bookmarks.destroy(params[:id])
  end

end

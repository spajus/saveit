class TagsController < ApplicationController
  self.responder = ActsAsApi::Responder

  before_filter :require_user
  respond_to :json

  def index
    respond_with current_tags, api_template: :with_bookmarks_count
  end

  def create
    respond_with current_tags.create(params[:tag]), api_template: :with_bookmarks_count
  end

  def update
    tag = current_tags.find(params[:id])
    respond_404("Tag not found: #{params[:id]}") if tag.nil?
    respond_with tag.update_attributes( params[:tag]), api_template: :with_bookmarks_count
  end

  def destroy
    tag = current_tags.find(params[:id])
    respond_404("Tag not found: #{params[:id]}") if tag.nil?
    respond_with tag.destroy()
  end

  def show
    respond_with current_tags.find(params[:id]), api_template: :with_bookmarks_count
  end

  def list_bookmarks
    respond_with current_tags.find(params[:tag_id]), api_template: :with_bookmarks
  end

end

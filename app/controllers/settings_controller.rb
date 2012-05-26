class SettingsController < ApplicationController
  before_filter :require_user
  respond_to :json

  def index
    respond_with current_settings
  end

  def show
    respond_with current_settings.find(params[:id])
  end

  def create
    respond_with current_settings.create(params[:setting])
  end

  def update
    respond_with current_settings.update(params[:id], params[:setting])
  end

  def destroy
    respond_with current_settings.destroy(params[:id])
  end

end

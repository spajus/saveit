class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])
    user ||= User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_url, :flash => {:success => 'Signed in!'}
  end
  def failure
    redirect root_url, :error => params[:message]
  end
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => 'Signed out!'
  end
end

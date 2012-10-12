class Users::AuthController < Devise::OmniauthCallbacksController

  def method_missing(provider)

    if !User.omniauth_providers.index(provider).nil?
      omniauth = env["omniauth.auth"]

      if current_user

        current_user.user_tokens.find_or_create_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
        flash[:notice] = "Authentication successful"
        redirect_to edit_user_registration_path

      else

        authentication = UserToken.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])

        if authentication

          flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => omniauth['provider']
          authentication.user.remember_me = true
          sign_in_and_redirect(:user, authentication.user)

        else

          email = omniauth.recursive_find_by_key("email")
          unless email.blank?
            user = User.find_or_initialize_by_email(email)
          else
            user = User.new
            #user.email = "#{omniauth[:uid]}#{omniauth[:provider]}.com"
          end

          user.apply_omniauth(omniauth)

          if user.save
            flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => omniauth['provider']
            user.remember_me = true
            sign_in_and_redirect(:user, user)
          else
            flash[:alert] = "Failed saving auth data: #{omniauth.except('extra')}"
            session[:omniauth] = omniauth.except('extra')
            redirect_to '/'
          end

        end #if authentication
      end #if current_user
    end #if User.omniauth_providers
  end #def method_missing

end

class OmniauthCallbacksController < ApplicationController
  skip_before_action :require_authentication, :verify_authenticity_token
  def auth
    if params[:source] == "google_oauth2"
      # Handle google auth code
      @user = User.from_omniauth(request.env['omniauth.auth'])

      if @user.persisted?
        start_new_session_for(@user)
        redirect_to root_path, notice: "You have signed in with Google."
      else
        redirect_to root_path, alert: "Something went wrong with google sign in"
      end
    end
  end
end
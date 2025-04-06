host = if Rails.env.development? 
  "http://localhost:3000"
else
  "https://example.com"
end

path = "/omniauth_callbacks/google_oauth2"

redirect_uri = host + path

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.credentials.dig(:google_oauth2, :client_id), 
    Rails.application.credentials.dig(:google_oauth2, :client_secret),
    {
      redirect_uri: redirect_uri,
      callback_path: path
    }
end
OmniAuth.config.allowed_request_methods = %i[get]
Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :xero_oauth2,
    ENV['CLIENT_ID'],
    ENV['CLIENT_SECRET'],
    scope: ENV['SCOPES'],
    state: 'sup3r$ecretSt@te',
    # provider_ignores_state: true
  )
end

# Since Omniauth 2.0.0, we need the following token verfication process
class TokenVerifier
  include ActiveSupport::Configurable
  include ActionController::RequestForgeryProtection

  def call(env)
    @request = ActionDispatch::Request.new(env.dup)
    raise OmniAuth::AuthenticityError unless verified_request?
  end

  private
  attr_reader :request
  delegate :params, :session, to: :request
end

OmniAuth.config.request_validation_phase = TokenVerifier.new

# by default the callback url / redirect_uri on developer.xero.com should be seet to /auth/xero_oauth2/callback
# to override it, added redirect_uri: 'https:/your.app/callback/url' to provider() function 
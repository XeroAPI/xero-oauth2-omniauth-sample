ENV['xero_api_client_id'] = '7615D492D8AA4E13977D1256F82403AF' #replace this with your own client_id
ENV['xero_api_client_secret'] = '66r5LdeJHCLB7wJKjKrTaFviQZaOzF9D-3kg0vcMwPory_PH' #replace this with your own client_secret

Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :xero_oauth2,
    ENV['xero_api_client_id'],
    ENV['xero_api_client_secret'],
    scope: 'openid profile email files accounting.transactions accounting.transactions.read accounting.reports.read accounting.journals.read accounting.settings accounting.settings.read accounting.contacts accounting.contacts.read accounting.attachments accounting.attachments.read offline_access',
  )
end

# by default the callback url / redirect_uri on developer.xero.com should be seet to /auth/xero_oauth2/callback
# to override it, added redirect_uri: 'https:/your.app/callback/url' to provider() function 
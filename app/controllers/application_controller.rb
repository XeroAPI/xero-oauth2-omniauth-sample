class ApplicationController < ActionController::Base
  def xero_api_get(xero_endpoint, user)
    if token_expired?(user)
      refresh_token(user)
    end

    resp = Faraday.get(xero_endpoint) do |req|
      req.headers['Authorization'] = 'Bearer ' + user.xeroAccessToken
      req.headers['Accept'] = 'application/json'
      req.headers['Content-Type'] = 'application/json'
      req.headers['xero-tenant-id'] = user.xeroTenantId
    end

    return resp
  end

  private

  def token_expired?(user)
    system_time = Time.now().to_i
    token_expiry_time = user.xeroTokenExpiresAt.to_i

    return (system_time >= token_expiry_time) ? true : false 
  end

  def refresh_token(user)
    system_time = Time.now().to_i
    xero_token_endpoint = 'https://identity.xero.com/connect/token'
    refresh_request_body_hash = {
      grant_type: 'refresh_token',
      refresh_token: user.xeroRefreshToken
    }

    resp = Faraday.post(xero_token_endpoint) do |req|
      req.headers['Authorization'] = 'Basic ' + Base64.strict_encode64(ENV['xero_api_client_id'] + ':' + ENV['xero_api_client_secret'])
      req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
      req.body = URI.encode_www_form(refresh_request_body_hash)
    end

    if resp.status == 200
      resp_hash = JSON.parse(resp.body)
      
      user.xeroAccessToken = resp_hash['access_token']
      user.xeroRefreshToken = resp_hash['refresh_token']
      user.xeroTokenExpiresAt = system_time + resp_hash['expires_in']
      user.save
    else
      redirect_to controller: 'home', action: 'index'
    end
  end
end

class OrganisationController < ApplicationController
  def index
    user = User.find_by(xeroUid: params[:xeroUid])
    
    @xeroUid = user.xeroUid

    @tokenExpiresAt = Time.at(user.xeroTokenExpiresAt.to_i).to_datetime

    resp = xero_api_get('https://api.xero.com/api.xro/2.0/Organisation', user)
    
    @org_info = JSON.parse(resp.body)

  end
end

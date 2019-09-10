class ContactsController < ApplicationController
  def index
    user = User.find_by(xeroUid: params[:xeroUid])
    
    @xeroUid = user.xeroUid
    
    resp = xero_api_get('https://api.xero.com/api.xro/2.0/Contacts', user)

    resp_hash = JSON.parse(resp.body)

    @contacts = resp_hash['Contacts']

    puts @contacts.inspect
  end
end

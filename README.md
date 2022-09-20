# Xero Ruby Oauth 2 Demo Rails Application
This rails application demonstates how omniauth-xero-oauth2 gem can be used to interface with Xero OAuth2 API. 

A quick demo of the app:
![demo-ruby-oauth2](https://user-images.githubusercontent.com/41350731/64585003-6443b180-d3da-11e9-82c3-116b41a99f8c.gif)

### Ruby & Rails version
```
ruby 2.6.0p0 (2018-12-25 revision 66547) [x86_64-darwin18]
Rails 5.2.3
```

### Configuration
Create a `.env` in the root of your project directory or replace the env.sample
```
CLIENT_ID=...
CLIENT_SECRET=...
SCOPES=...
```

Notice that there is no redirect_uri specified here. By default omniauth uses /auth/xero_oauth2/callback. 

You can use your own callback url by adding redirect_uri: 'https://your.apps/callback/url' to provider() function's input.  

Update local omniauth dependency in Gemfile:

```
gem 'omniauth-xero-oauth2', :path => '../omniauth-xero-oauth2' # as a local gem
```

Run follow commands to start up the application:

```
$ bundle install 
$ rake db:migrate
$ rails start
```

### Database creation
Uses sqlite3. This is defaulted by rails application.
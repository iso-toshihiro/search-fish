class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate

  private

  def authenticate
    authenticate_or_request_with_http_basic do |user, pass|
      if Rails.env == 'production'
        login_user = ENV['LOGIN_USER']
        login_pass = ENV['LOGIN_PASS']
      else
        login_user = Settings.user
        login_pass = Settings.password
      end
      user == login_user && pass == login_pass
    end
  end
end

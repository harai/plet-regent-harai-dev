class ApplicationController < ActionController::Base
  http_basic_authenticate_with(
    name: ENV['ONEOP_BASIC_AUTH_NAME'],
    password: ENV['ONEOP_BASIC_AUTH_PASSWORD'])
end

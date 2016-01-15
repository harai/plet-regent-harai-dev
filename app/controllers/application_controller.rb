class ApplicationController < ActionController::Base
  http_basic_authenticate_with(
    name: ENV['REGENT_BASIC_AUTH_NAME'],
    password: ENV['REGENT_BASIC_AUTH_PASSWORD'])
end

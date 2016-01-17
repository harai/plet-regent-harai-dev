class WelcomeController < ApplicationController
  def hi
    json_request = JSON.parse(request.body.read)
    require 'pp'
    pp json_request
    res = sp_client.accounts.get 'https://api.stormpath.com/v1/accounts/BR5Wfj3SzFKmwAQTS8SLK'
    count = res.custom_data[:foobar]
    res.custom_data[:foobar] += 1
    res.custom_data.save
    publish_message("The current count is #{count}.")
    respond_to do |format|
      format.json do
        render json: {
          status: "ok",
          message: "Success!",
          count: count,
          echo: json_request,
        }
      end
      format.all do
        render nothing: true
      end
    end
  end

  private

  def sp_client
    Stormpath::Client.new({
       api_key: {
         id: ENV['STORMPATH_CLIENT_APIKEY_ID'], secret: ENV['STORMPATH_CLIENT_APIKEY_SECRET'],
       }
    })
  end

  def publish_message(message)
    sns_client.publish({
      topic_arn: ENV['AWS_SNS_TOPIC'],
      message: message,
    })
  end

  def sns_client
    Aws::SNS::Client.new
  end
end

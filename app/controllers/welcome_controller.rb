class WelcomeController < ApplicationController
  def hi
    res = sp_client.accounts.get 'https://api.stormpath.com/v1/accounts/BR5Wfj3SzFKmwAQTS8SLK'
    count = res.custom_data[:foobar]
    res.custom_data[:foobar] += 1
    res.custom_data.save
    respond_to do |format|
      format.json do
        render json: {
          status: "ok",
          message: "Success!",
          count: count,
        }
      end
    end
  end

  private

  def sp_client
    Stormpath::Client.new({
       api_key: {
         id: ENV['STORMPATH_ID'], secret: ENV['STORMPATH_SECRET'],
       }
    })
  end
end

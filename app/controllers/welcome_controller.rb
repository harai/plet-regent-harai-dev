class WelcomeController < ApplicationController
  def hi
    respond_to do |format|
      format.json do
        render json: {
          status: "ok",
          message: "Success!",
        }
      end
    end
  end

end

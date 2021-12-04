class HomeController < ApplicationController
  def greatings
    render json: { greetings: I18n.t('.hello') }
  end
end

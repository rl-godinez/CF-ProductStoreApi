require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "GET /greatings" do
    it "returns http success" do
      get "/home/greatings"
      expect(response).to have_http_status(:success)
    end
  end

end

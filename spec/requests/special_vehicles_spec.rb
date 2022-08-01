require 'rails_helper'

RSpec.describe "Users::SpecialVehicles", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/users/special_vehicles/index"
      expect(response).to have_http_status(:success)
    end
  end

end

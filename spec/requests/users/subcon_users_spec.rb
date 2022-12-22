require 'rails_helper'

RSpec.describe "Users::SubconUsers", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/users/subcon_users/index"
      expect(response).to have_http_status(:success)
    end
  end

end

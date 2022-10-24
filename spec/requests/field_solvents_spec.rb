require 'rails_helper'

RSpec.describe "FieldSolvents", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/field_solvents/index"
      expect(response).to have_http_status(:success)
    end
  end

end

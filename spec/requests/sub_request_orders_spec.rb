require 'rails_helper'

RSpec.describe 'SubRequestOrders', type: :request do
  let!(:user) { create(:user) }
  let!(:business) { create(:business, user: user) }
  let!(:order) { create(:order, business: business) }
  let!(:worker) { create(:worker, business: business) }
  let!(:document) { create(:document, business: business, request_order: request_order) }

  describe 'GET /index' do
    pending "add some examples (or delete) #{__FILE__}"
  end

  describe 'GET/new' do
    let!(:request_order) { create(:request_order, business: business, order: order, status: 'approved') }

    before do
      sign_in user
      get new_users_request_order_sub_request_order_path(request_order)
    end

    it '指定のURLにリダイレクトされる' do
      expect(response).to redirect_to(users_request_order_url(request_order))
    end
  end

  describe 'Post/create' do
    let!(:request_order) { create(:request_order, business: business, order: order, status: 'approved') }

    before do
      sign_in user
      post users_request_order_sub_request_orders_path(request_order)
    end

    it '指定のURLにリダイレクトされる' do
      expect(response).to redirect_to(users_request_order_url(request_order))
    end
  end
end

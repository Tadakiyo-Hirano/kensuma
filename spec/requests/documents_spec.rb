require 'rails_helper'

RSpec.describe 'Documents', type: :request do
  let!(:user) { create(:user) }
  let!(:business) { create(:business, user: user) }
  let!(:order) { create(:order, business: business) }
  let!(:worker) { create(:worker, business: business) }
  let!(:document) { create(:document, business: business, request_order: request_order) }
  let(:doc_19th) { create(:document, :doc_19th, business: business, request_order: request_order) }

  describe 'GET /index' do
    pending "add some examples (or delete) #{__FILE__}"
  end

  describe 'GET/edit' do
    subject { doc_19th }

    let!(:request_order) { create(:request_order, business: business, order: order, status: 'approved') }

    before(:each) do
      sign_in user
      get edit_users_request_order_document_path(request_order, subject)
    end

    it '指定のURLにリダイレクトされる' do
      expect(response).to redirect_to(users_request_order_document_url)
    end
  end

  describe 'PATCH/update' do
    subject { doc_19th }

    let!(:request_order) { create(:request_order, business: business, order: order, status: 'approved') }

    before(:each) do
      sign_in user
      patch users_request_order_document_path(request_order, subject)
    end

    it '指定のURLにリダイレクトされる' do
      expect(response).to redirect_to(users_request_order_document_url)
    end
  end
end

require 'rails_helper'
# pending
RSpec.xdescribe 'RequestOrders', type: :request do
  let!(:user) { create(:user) }
  let!(:user_first_sub) { create(:user, name: '1次下請けユーザー', email: 'first_sub-user@example.com', password: '123456', password_confirmation: '123456', role: 'admin') }
  let!(:business) { create(:business, user: user) }
  let!(:business_first_sub) { create(:business, user: user_first_sub) }
  let!(:order) { create(:order, business: business) }

  describe 'GET/edit_approval_status' do
    let!(:request_order) { create(:request_order, business: business, order: order) }
    let!(:request_order_first_sub) { create(:request_order, parent_id: request_order.id, business: business_first_sub, order: order) }

    context '元請の場合' do
      before(:each) do
        sign_in user
        get users_request_order_edit_approval_status_path(request_order)
      end

      it '正常レスポンスが返ってくる' do
        expect(response).to have_http_status :ok
      end
    end

    context '下請けの場合' do
      before(:each) do
        sign_in user_first_sub
        get users_request_order_edit_approval_status_path(request_order_first_sub)
      end

      it '指定のURLにリダイレクトされる' do
        expect(response).to redirect_to(users_request_order_url)
      end
    end
  end

  describe 'Post/update_approval_status' do
    let!(:request_order) { create(:request_order, business: business, order: order, status: 'approved') }
    let!(:request_order_first_sub) { create(:request_order, parent_id: request_order.id, business: business_first_sub, order: order, status: 'approved') }

    context '元請が自分自身の承認をキャンセルした場合' do
      before(:each) do
        sign_in user
        post users_request_order_update_approval_status_path(uuid: request_order.uuid, resecission_uuid: request_order.uuid)
      end

      it '元請のステータスがrequestedに変更される' do
        expect(request_order.reload.status).to eq 'requested'
      end

      it '下請けのステータスがrequestedに変更されない' do
        expect(request_order_first_sub.reload.status).to eq 'approved'
      end
    end

    context '元請が一次下請けの承認をキャンセルした場合' do
      before(:each) do
        sign_in user
        post users_request_order_update_approval_status_path(uuid: request_order.uuid, resecission_uuid: request_order_first_sub.uuid)
      end

      it '元請のステータスがrequestedに変更される' do
        expect(request_order.reload.status).to eq 'requested'
      end

      it '下請けのステータスがrequestedに変更される' do
        expect(request_order_first_sub.reload.status).to eq 'requested'
      end
    end

    context '下請けが一次下請けの承認をキャンセルした場合' do
      before(:each) do
        sign_in user_first_sub
        post users_request_order_update_approval_status_path(uuid: request_order_first_sub.uuid,
          resecission_uuid: request_order_first_sub.uuid)
      end

      it '指定のURLにリダイレクトされる' do
        expect(response).to redirect_to(users_request_order_url)
      end
    end
  end
end

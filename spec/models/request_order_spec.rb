require 'rails_helper'

RSpec.describe RequestOrder, type: :model do
  let(:business) { create(:business) }
  let(:order) { create(:order) }
  let(:request_order) { create(:request_order, business: business, order: order) }

  describe 'アソシエーションについて' do
    context '紐つく会社情報がある場合' do
      subject { request_order.business }

      it '紐つく会社情報を返すこと' do
        expect(subject).to eq(business)
      end
    end

    context '紐つく現場情報がある場合' do
      subject { request_order.order }

      it '紐つく現場情報を返すこと' do
        expect(subject).to eq(order)
      end
    end
  end
end

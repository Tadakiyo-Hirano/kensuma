require 'rails_helper'

RSpec.describe CarVoluntaryInsurance, type: :model do
  let :company do
    create(:car_insurance_company)
  end

  let :car do
    create(:car)
  end

  let :voluntary do
    create(:car_voluntary_insurance, company_voluntary: company, car_voluntary: car)
  end

  describe 'アソシエーションについて' do
    context '紐つく車両がある場合' do
      subject do
        voluntary.car_voluntary
      end

      it '紐つく車両を返すこと' do
        expect(subject).to eq(car)
      end
    end

    context '紐つく保険会社がある場合' do
      subject do
        voluntary.company_voluntary
      end

      it '紐つく保険会社を返すこと' do
        expect(subject).to eq(company)
      end
    end
  end
end

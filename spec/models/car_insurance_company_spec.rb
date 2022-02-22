require 'rails_helper'

RSpec.describe CarInsuranceCompany, type: :model do
  let :company do
    create(:car_insurance_company)
  end

  let :cars do
    create_list(:car, 2)
  end

  describe 'バリデーションについて' do
    subject do
      company
    end

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    it '保険会社名が無い場合、無効であること' do
      subject.name = nil
      expect(subject).to be_invalid
      expect(subject.errors.full_messages).to include('保険会社名を入力してください')
    end
  end

  describe '車両とのアソシエーションについて' do
    context '紐つく車両がある場合' do
      subject do
        company.car_voluntaries << cars
      end

      it '紐つく車両を返すこと' do
        expect(subject).to eq(cars)
      end
    end
  end
end

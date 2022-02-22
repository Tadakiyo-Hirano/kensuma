require 'rails_helper'

RSpec.describe Car, type: :model do
  let :car do
    build(:car)
  end

  describe 'バリデーションについて' do
    subject do
      car
    end

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    describe '#owner_name' do
      context '存在しない場合' do
        before :each do
          subject.owner_name = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('車両所有者氏名を入力してください')
        end
      end
    end

    describe '#vehicle_model' do
      context '存在しない場合' do
        before :each do
          subject.vehicle_model = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('車両型式を入力してください')
        end
      end
    end

    describe '#vehicle_number' do
      context '存在しない場合' do
        before :each do
          subject.vehicle_number = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('車両番号を入力してください')
        end
      end
    end

    describe '#vehicle_inspection_start_on' do
      context '存在しない場合' do
        before :each do
          subject.vehicle_inspection_start_on = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('車検初めを入力してください')
        end
      end
    end

    describe '#vehicle_inspection_end_on' do
      context '存在しない場合' do
        before :each do
          subject.vehicle_inspection_end_on = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('車検終わりを入力してください')
        end
      end
    end

    describe '#liability_securities_number' do
      context '存在しない場合' do
        before :each do
          subject.liability_securities_number = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('自賠責証券番号を入力してください')
        end
      end
    end

    describe '#liability_insurance_start_on' do
      context '存在しない場合' do
        before :each do
          subject.liability_insurance_start_on = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('自賠責保険初めを入力してください')
        end
      end
    end

    describe '#liability_insurance_end_on' do
      context '存在しない場合' do
        before :each do
          subject.liability_insurance_end_on = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('自賠責保険終わりを入力してください')
        end
      end
    end
  end

  describe '保険会社とのアソシエーションについて' do
    let :company do
      create(:car_insurance_company)
    end

    let :companies do
      create_list(:car_insurance_company, 2)
    end

    context '紐つく自賠責保険会社がある場合' do
      subject do
        car.car_insurance_company = company
      end

      it '紐つく自賠保険会社を返すこと' do
        expect(subject).to eq(company)
      end
    end

    context '紐つく任意保険会社がある場合' do
      subject do
        car.company_voluntaries << companies
      end

      it '紐つく任意保険会社を返すこと' do
        expect(subject).to eq(companies)
      end
    end
  end
end

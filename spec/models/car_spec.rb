require 'rails_helper'

RSpec.describe Car, type: :model do
  let(:car) { build(:car) }

  describe 'バリデーションについて' do
    subject { car }

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    describe '#usage' do
      context '存在しない場合' do
        before(:each) { subject.usage = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('使用目的を入力してください')
        end
      end
    end

    describe '#owner_name' do
      context '存在しない場合' do
        before(:each) { subject.owner_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('車両所有者氏名を入力してください')
        end
      end
    end

    describe '#vehicle_name' do
      context '存在しない場合' do
        before(:each) { subject.vehicle_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('車両名を入力してください')
        end
      end
    end

    describe '#vehicle_model' do
      context '存在しない場合' do
        before(:each) { subject.vehicle_model = nil }

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
        before(:each) { subject.vehicle_number = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('車両番号を入力してください')
        end
      end

      %i[
        012345678987
        あ
        品川あ5001234
        品川500あ12-34
      ].each do |vehicle_number|
        context '不正なvehicle_numberの場合' do
          before(:each) { subject.vehicle_number = vehicle_number }

          it 'バリデーションに落ちること' do
            expect(subject).to be_invalid
          end

          it 'バリデーションのエラーが正しいこと' do
            subject.valid?
            expect(subject.errors.full_messages).to include('車両番号は地域名,分類番号,平仮名等,一連指定番号で入力してください(例：品川500あ1234)')
          end
        end
      end
    end

    describe '#vehicle_inspection_start_on' do
      context '存在しない場合' do
        before(:each) { subject.vehicle_inspection_start_on = nil }

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
        before(:each) { subject.vehicle_inspection_end_on = nil }

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
        before(:each) { subject.liability_securities_number = nil }

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
        before(:each) { subject.liability_insurance_start_on = nil }

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
        before(:each) { subject.liability_insurance_end_on = nil }

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
    let(:company) { create(:car_insurance_company) }
    let(:companies) { create_list(:car_insurance_company, 2) }

    context '紐つく自賠責保険会社がある場合' do
      subject { car.car_insurance_company = company }

      it '紐つく自賠保険会社を返すこと' do
        expect(subject).to eq(company)
      end
    end

    context '紐つく任意保険会社がある場合' do
      subject { car.company_voluntaries << companies }

      it '紐つく任意保険会社を返すこと' do
        expect(subject).to eq(companies)
      end
    end
  end
end

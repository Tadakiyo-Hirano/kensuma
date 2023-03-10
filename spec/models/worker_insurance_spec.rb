require 'rails_helper'

RSpec.describe WorkerInsurance, type: :model do
  let(:worker_insurance) { create(:worker_insurance) }

  describe 'バリデーションについて' do
    subject do
      worker_insurance
    end

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    describe '#health_insurance_type' do
      context '存在しない場合' do
        before :each do
          subject.health_insurance_type = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('健康保険のタイプを入力してください')
        end
      end
    end

    describe '#health_insurance_name' do
      context '健康保険が健康保険組合または、建設国保の場合' do
        before :each do
          subject.health_insurance_name = nil
        end

        it 'バリデーションに落ちること(健康保険組合)' do
          subject.health_insurance_type = :health_insurance_association
          expect(subject).to be_invalid
        end

        it 'バリデーションに落ちること(建設国保)' do
          subject.health_insurance_type = :construction_national_health_insurance
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.invalid?
          expect(subject.errors.full_messages).to include('健康保険の名前を入力してください')
        end
      end

      context '健康保険が健康保険組合、建設国保以外の場合' do
        before :each do
          subject.health_insurance_name = nil
        end

        it 'バリデーションにとおること(協会けんぽ)' do
          subject.health_insurance_type = :japan_health_insurance_association
          expect(subject).to be_valid
        end

        it 'バリデーションにとおること(国民健康保険)' do
          subject.health_insurance_type = :national_health_insurance
          expect(subject).to be_valid
        end

        it 'バリデーションにとおること(適応除外)' do
          subject.health_insurance_type = :exemption
          expect(subject).to be_valid
        end
      end
    end

    describe '#pension_insurance_type' do
      context '存在しない場合' do
        before :each do
          subject.pension_insurance_type = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('年金保険のタイプを入力してください')
        end
      end
    end

    describe '#employment_insurance_type' do
      context '存在しない場合' do
        before :each do
          subject.employment_insurance_type = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('雇用保険のタイプを入力してください')
        end
      end
    end

    describe '#employment_insurance_number' do
      context '被保険者の場合' do
        before :each do
          %i[
            12345
            123
          ].each do |number|
            subject.employment_insurance_number = number
          end
        end

        it 'バリデーションに落ちること' do
          subject.employment_insurance_type = :insured
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.employment_insurance_type = :insured
          subject.valid?
          expect(subject.errors.full_messages).to include('被保険者番号の下4桁は4文字で入力してください')
        end
      end

      context '被保険者の場合' do
        before :each do
          %i[
            12345
            123
          ].each do |number|
            subject.employment_insurance_number = number
          end
        end

        it 'バリデーションにとおること' do
          subject.employment_insurance_type = :day
          expect(subject).to be_valid
        end

        it 'バリデーションにとおること' do
          subject.employment_insurance_type = :exemption
          expect(subject).to be_valid
        end
      end
    end

    describe '#severance_pay_mutual_aid_type' do
      context '存在しない場合' do
        before :each do
          subject.severance_pay_mutual_aid_type = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('建設業退職金共済制度を入力してください')
        end
      end
    end
  end
end

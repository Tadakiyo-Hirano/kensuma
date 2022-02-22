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
      context '4場合' do
        before :each do
          %i[
            12345
            123
          ].each do |number|
            subject.employment_insurance_number = number
          end
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('被保険者番号の下4桁は4文字で入力してください')
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

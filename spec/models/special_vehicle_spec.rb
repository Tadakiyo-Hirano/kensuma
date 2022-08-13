require 'rails_helper'

RSpec.describe SpecialVehicle, type: :model do
  let :special_vehicle do
    build(:special_vehicle)
  end

  describe 'バリデーションについて' do
    subject do
      special_vehicle
    end

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    describe '#check_exp_date_year' do
      context '存在しない場合' do
        before :each do
          subject.check_exp_date_year = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('自主検査有効期限(正規・年次)を入力してください')
        end
      end
    end

    describe '#check_exp_date_month' do
      context '存在しない場合' do
        before :each do
          subject.check_exp_date_month = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('自主検査有効期限(正規・月次)を入力してください')
        end
      end
    end

    describe '#check_exp_date_specific' do
      context '存在しない場合' do
        before :each do
          subject.check_exp_date_specific = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('自主検査有効期限(特定)を入力してください')
        end
      end
    end

    describe '#check_exp_date_machine' do
      context '存在しない場合' do
        before :each do
          subject.check_exp_date_machine = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('移動式クレーン等の性能検査有効期限を入力してください')
        end
      end
    end

    describe '#check_exp_date_car' do
      context '存在しない場合' do
        before :each do
          subject.check_exp_date_car = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('自動車検査証有効期限を入力してください')
        end
      end
    end
  end
end

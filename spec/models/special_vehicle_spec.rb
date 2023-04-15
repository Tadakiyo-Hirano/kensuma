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

    describe '#name' do
      context '存在しない場合' do
        before :each do
          subject.name = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('名称を入力してください')
        end
      end
    end

    describe '#maker' do
      context '存在しない場合' do
        before :each do
          subject.maker = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('メーカーを入力してください')
        end
      end
    end
    
    describe '#owning_company_name' do
      context '存在しない場合' do
        before :each do
          subject.owning_company_name = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('所有会社名を入力してください')
        end
      end
    end

    describe '#year_manufactured' do
      context '存在しない場合' do
        before :each do
          subject.year_manufactured = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('製造年を入力してください')
        end
      end
    end

    describe '#control_number' do
      context '存在しない場合' do
        before :each do
          subject.control_number = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('管理番号(整理番号)を入力してください')
        end
      end
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
          expect(subject.errors.full_messages).to include('年次を入力してください')
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
          expect(subject.errors.full_messages).to include('月次を入力してください')
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
    
    describe '#vehicle_type' do
      context '存在しない場合' do
        before :each do
          subject.vehicle_type = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('登録する車両を入力してください')
        end
      end
    end
  end
end

require 'rails_helper'

RSpec.describe FieldSpecialVehicle, type: :model do
  let(:order_field_special_vehicle) { build(:order_field_special_vehicle) }
  let(:request_order_field_special_vehicle) { build(:request_order_field_special_vehicle) }

  describe 'order側バリデーションについて' do
    subject { order_field_special_vehicle }

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    describe '#vehicle_type' do
      context '存在しない場合' do
        before(:each) { subject.vehicle_type = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#carry_on_company_name' do
      context '存在しない場合' do
        before(:each) { subject.carry_on_company_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#owning_company_name' do
      context '存在しない場合' do
        before(:each) { subject.owning_company_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#use_company_name' do
      context '存在しない場合' do
        before(:each) { subject.use_company_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#carry_on_date' do
      context '存在しない場合' do
        before(:each) { subject.carry_on_date = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#carry_out_date' do
      context '存在しない場合' do
        before(:each) { subject.carry_out_date = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#use_place' do
      context '存在しない場合' do
        before(:each) { subject.use_place = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#lease_type' do
      context '存在しない場合' do
        before(:each) { subject.lease_type = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end
  end

  describe 'request_order側バリデーションについて' do
    subject { request_order_field_special_vehicle }

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    describe '#vehicle_type' do
      context '存在しない場合' do
        before(:each) { subject.vehicle_type = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#carry_on_company_name' do
      context '存在しない場合' do
        before(:each) { subject.carry_on_company_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#owning_company_name' do
      context '存在しない場合' do
        before(:each) { subject.owning_company_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#use_company_name' do
      context '存在しない場合' do
        before(:each) { subject.use_company_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#carry_on_date' do
      context '存在しない場合' do
        before(:each) { subject.carry_on_date = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#carry_out_date' do
      context '存在しない場合' do
        before(:each) { subject.carry_out_date = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#use_place' do
      context '存在しない場合' do
        before(:each) { subject.use_place = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#lease_type' do
      context '存在しない場合' do
        before(:each) { subject.lease_type = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end
  end
end

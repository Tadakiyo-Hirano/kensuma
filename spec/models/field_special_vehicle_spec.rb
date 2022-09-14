require 'rails_helper'

RSpec.describe FieldSpecialVehicle, type: :model do
  let(:order_field_special_vehicle) { build(:order_field_special_vehicle) }
  let(:request_order_field_special_vehicle) { build(:request_order_field_special_vehicle) }

  describe 'order側バリデーションについて' do
    subject { order_field_special_vehicle }

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end
    
    describe '#content' do
      context '存在しない場合' do
        before(:each) { subject.content = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#vehicle_name' do
      context '存在しない場合' do
        before(:each) { subject.vehicle_name = nil }

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

    describe '#content' do
      context '存在しない場合' do
        before(:each) { subject.content = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#vehicle_name' do
      context '存在しない場合' do
        before(:each) { subject.vehicle_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end
  end
end

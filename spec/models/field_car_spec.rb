require 'rails_helper'

RSpec.describe FieldCar, type: :model do
  let(:order_field_car) { build(:order_field_car) }
  let(:request_order_field_car) { build(:request_order_field_car) }

  describe 'order側バリデーションについて' do
    subject { order_field_car }

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    describe '#car_name' do
      context '存在しない場合' do
        before(:each) { subject.car_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#content' do
      context '存在しない場合' do
        before(:each) { subject.content = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end
  end

  describe 'request_order側バリデーションについて' do
    subject { request_order_field_car }

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    describe '#car_name' do
      context '存在しない場合' do
        before(:each) { subject.car_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#content' do
      context '存在しない場合' do
        before(:each) { subject.content = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end
  end
end

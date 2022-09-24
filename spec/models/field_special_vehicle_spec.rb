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

    describe '#use_place' do
      context '100文字の場合' do
        before(:each) { subject.use_place = 'a' * 100 }

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end
      end

      context '101文字の場合' do
        before(:each) { subject.use_place = 'a' * 101 }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#contact_prevention' do
      context '40文字の場合' do
        before(:each) { subject.contact_prevention = 'a' * 40 }

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end
      end

      context '41文字の場合' do
        before(:each) { subject.contact_prevention = 'a' * 41 }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#precautions' do
      context '500文字の場合' do
        before(:each) { subject.precautions = 'a' * 500 }

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end
      end

      context '501文字の場合' do
        before(:each) { subject.precautions = 'a' * 501 }

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

    describe '#use_place' do
      context '100文字の場合' do
        before(:each) { subject.use_place = 'a' * 100 }

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end
      end

      context '101文字の場合' do
        before(:each) { subject.use_place = 'a' * 101 }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#contact_prevention' do
      context '40文字の場合' do
        before(:each) { subject.contact_prevention = 'a' * 40 }

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end
      end

      context '41文字の場合' do
        before(:each) { subject.contact_prevention = 'a' * 41 }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#precautions' do
      context '500文字の場合' do
        before(:each) { subject.precautions = 'a' * 500 }

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end
      end

      context '501文字の場合' do
        before(:each) { subject.precautions = 'a' * 501 }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end
  end
end

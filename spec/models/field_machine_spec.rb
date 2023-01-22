require 'rails_helper'

RSpec.describe FieldMachine, type: :model do
  let(:order_field_machine) { build(:order_field_machine) }
  let(:request_order_field_machine) { build(:request_order_field_machine) }

  describe 'order側バリデーションについて' do
    subject { order_field_machine }

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

    describe '#machine_name' do
      context '存在しない場合' do
        before(:each) { subject.machine_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end
  end

  describe 'request_order側バリデーションについて' do
    subject { request_order_field_machine }

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

    describe '#machine_name' do
      context '存在しない場合' do
        before(:each) { subject.machine_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end
  end
end

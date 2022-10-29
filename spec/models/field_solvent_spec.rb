require 'rails_helper'

RSpec.describe FieldSolvent, type: :model do
  let(:order_field_solvent) { build(:order_field_solvent) }
  let(:request_order_field_solvent) { build(:request_order_field_solvent) }

  describe 'order側バリデーションについて' do
    subject { order_field_solvent }

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

    describe '#solvent_name' do
      context '存在しない場合' do
        before(:each) { subject.solvent_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#using_location' do
      context '100文字の場合' do
        before(:each) { subject.using_location = 'a' * 100 }

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end
      end

      context '101文字の場合' do
        before(:each) { subject.using_location = 'a' * 101 }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#storing_place' do
      context '100文字の場合' do
        before(:each) { subject.storing_place = 'a' * 100 }

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end
      end

      context '101文字の場合' do
        before(:each) { subject.storing_place = 'a' * 101 }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#using_tool' do
      context '100文字の場合' do
        before(:each) { subject.using_tool = 'a' * 40 }

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end
      end

      context '101文字の場合' do
        before(:each) { subject.using_tool = 'a' * 41 }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end
  end

  describe 'request_order側バリデーションについて' do
    subject { request_order_field_solvent }

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

    describe '#solvent_name' do
      context '存在しない場合' do
        before(:each) { subject.solvent_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#using_location' do
      context '100文字の場合' do
        before(:each) { subject.using_location = 'a' * 100 }

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end
      end

      context '101文字の場合' do
        before(:each) { subject.using_location = 'a' * 101 }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#storing_place' do
      context '100文字の場合' do
        before(:each) { subject.storing_place = 'a' * 100 }

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end
      end

      context '101文字の場合' do
        before(:each) { subject.storing_place = 'a' * 101 }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#using_tool' do
      context '100文字の場合' do
        before(:each) { subject.using_tool = 'a' * 40 }

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end
      end

      context '101文字の場合' do
        before(:each) { subject.using_tool = 'a' * 41 }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end
  end
end

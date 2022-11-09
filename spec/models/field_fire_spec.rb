require 'rails_helper'

RSpec.describe FieldFire, type: :model do
  let(:order_field_fire) { build(:order_field_fire) }
  let(:request_order_field_fire) { build(:request_order_field_fire) }

  describe 'order側バリデーションについて' do
    subject { order_field_fire }

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    describe '#use_place' do
      context '存在しない場合' do
        before(:each) { subject.use_place = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end

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

    describe '#other_use_target' do
      context '10文字の場合' do
        before(:each) { subject.other_use_target = 'a' * 10 }

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end
      end

      context '11文字の場合' do
        before(:each) { subject.other_use_target = 'a' * 11 }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#usage_period_start' do
      context '存在しない場合' do
        before(:each) { subject.usage_period_start = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#usage_period_end' do
      context '存在しない場合' do
        before(:each) { subject.usage_period_end = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#other_fire_management' do
      context '10文字の場合' do
        before(:each) { subject.other_fire_management = 'a' * 20 }

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end
      end

      context '11文字の場合' do
        before(:each) { subject.other_fire_management = 'a' * 21 }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#usage_time_start' do
      context '存在しない場合' do
        before(:each) { subject.usage_time_start = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#usage_time_end' do
      context '存在しない場合' do
        before(:each) { subject.usage_time_end = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#precautions' do
      context '存在しない場合' do
        before(:each) { subject.precautions = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end

      context '40文字の場合' do
        before(:each) { subject.precautions = 'a' * 40 }

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end
      end

      context '41文字の場合' do
        before(:each) { subject.precautions = 'a' * 41 }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#fire_origin_responsible' do
      context '存在しない場合' do
        before(:each) { subject.fire_origin_responsible = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#fire_use_responsible' do
      context '存在しない場合' do
        before(:each) { subject.fire_use_responsible = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end
  end

  describe 'request_order側バリデーションについて' do
    subject { request_order_field_fire }

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    describe '#use_place' do
      context '存在しない場合' do
        before(:each) { subject.use_place = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end

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

    describe '#other_use_target' do
      context '10文字の場合' do
        before(:each) { subject.other_use_target = 'a' * 10 }

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end
      end

      context '11文字の場合' do
        before(:each) { subject.other_use_target = 'a' * 11 }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#usage_period_start' do
      context '存在しない場合' do
        before(:each) { subject.usage_period_start = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#usage_period_end' do
      context '存在しない場合' do
        before(:each) { subject.usage_period_end = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#other_fire_management' do
      context '10文字の場合' do
        before(:each) { subject.other_fire_management = 'a' * 20 }

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end
      end

      context '11文字の場合' do
        before(:each) { subject.other_fire_management = 'a' * 21 }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#usage_time_start' do
      context '存在しない場合' do
        before(:each) { subject.usage_time_start = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#usage_time_end' do
      context '存在しない場合' do
        before(:each) { subject.usage_time_end = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#precautions' do
      context '存在しない場合' do
        before(:each) { subject.precautions = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end

      context '40文字の場合' do
        before(:each) { subject.precautions = 'a' * 40 }

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end
      end

      context '41文字の場合' do
        before(:each) { subject.precautions = 'a' * 41 }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#fire_origin_responsible' do
      context '存在しない場合' do
        before(:each) { subject.fire_origin_responsible = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#fire_use_responsible' do
      context '存在しない場合' do
        before(:each) { subject.fire_use_responsible = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end
  end
end

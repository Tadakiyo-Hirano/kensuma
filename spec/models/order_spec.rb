require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { create(:order) }

  describe 'バリデーションについて' do
    subject { order }

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    describe '#status' do
      context '存在しない場合' do
        before(:each) { subject.status = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
          subject.valid?
          expect(subject.errors.full_messages).to include('Statusを入力してください')
        end
      end
    end

    describe '#site_uu_id' do
      context '存在しない場合' do
        before(:each) { subject.site_uu_id = nil }

        it 'バリデーションに落ちること' do
          expect(subject.site_uu_id).to be_falsey
        end
      end
    end

    describe '#site_name' do
      context '存在しない場合' do
        before(:each) { subject.site_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
          subject.valid?
          expect(subject.errors.full_messages).to include('現場名を入力してください')
        end
      end
    end

    describe '#order_name' do
      context '存在しない場合' do
        before(:each) { subject.order_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
          subject.valid?
          expect(subject.errors.full_messages).to include('発注者名前を入力してください')
        end
      end
    end

    describe '#order_post_code' do
      context '存在しない場合' do
        before(:each) { subject.order_post_code = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
          subject.valid?
          expect(subject.errors.full_messages).to include('発注者郵便番号を入力してください')
        end
      end

      %i[
        01234567
        0123
        012345
        012-3456
      ].each do |order_post_code|
        context '不正なpost_codeの場合' do
          before :each do
            subject.order_post_code = order_post_code
          end

          it 'バリデーションに落ちること' do
            expect(subject).to be_invalid
            subject.valid?
            expect(subject.errors.full_messages).to include('発注者郵便番号は不正な値です')
          end
        end
      end
    end

    describe '#order_address' do
      context '存在しない場合' do
        before(:each) { subject.order_address = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
          subject.valid?
          expect(subject.errors.full_messages).to include('発注者住所を入力してください')
        end
      end
    end
  end
end

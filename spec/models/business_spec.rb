require 'rails_helper'

RSpec.describe Business, type: :model do
  let :business do
    build(:business)
  end

  describe 'バリデーションについて' do
    subject do
      business
    end

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    describe '#uuid' do
      context '存在しない場合' do
        before :each do
          subject.uuid = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('事業所IDを入力してください')
        end
      end
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
          expect(subject.errors.full_messages).to include('事業所名を入力してください')
        end
      end
    end

    describe '#name_kana' do
      context '存在しない場合' do
        before :each do
          subject.name_kana = nil
        end

        it 'バリデーションが通ること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('事業所名(カナ)はカタカナで入力して下さい。')
        end

        %i[
          てすときぎょう
          TEST企業
        ].each do |name_kana|
          context '不正なname_kanaの場合' do
            before :each do
              subject.name_kana = name_kana
            end

            it 'バリデーションに落ちること' do
              expect(subject).to be_invalid
            end

            it 'バリデーションのエラーが正しいこと' do
              subject.valid?
              expect(subject.errors.full_messages).to include('事業所名(カナ)はカタカナで入力して下さい。')
            end
          end
        end
      end
    end

    describe '#branch_name' do
      context '存在しない場合' do
        before :each do
          subject.branch_name = nil
        end

        it 'バリデーションが通ること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('支店名、営業所名を入力してください')
        end
      end
    end

    describe '#representative_name' do
      context '存在しない場合' do
        before :each do
          subject.representative_name = nil
        end

        it 'バリデーションが通ること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('代表者名を入力してください')
        end
      end
    end

    describe '#email' do
      context '存在しない場合' do
        before :each do
          subject.email = nil
        end

        it 'バリデーションが通ること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('事業所メールアドレスを入力してください')
        end
      end

      %i[
        email0.com
        あああ.com
        今井.com
        @@.com
      ].each do |email|
        context '不正なemailの場合' do
          before :each do
            subject.email = email
          end

          it 'バリデーションに落ちること' do
            expect(subject).to be_invalid
          end

          it 'バリデーションのエラーが正しいこと' do
            subject.valid?
            expect(subject.errors.full_messages).to include('事業所メールアドレスは不正な値です')
          end
        end
      end
    end

    describe '#address' do
      context '存在しない場合' do
        before :each do
          subject.address = nil
        end

        it 'バリデーションが通ること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('住所を入力してください')
        end
      end
    end

    describe '#post_code' do
      context '存在しない場合' do
        before :each do
          subject.post_code = nil
        end

        it 'バリデーションが通ること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('郵便番号を入力してください')
        end
      end

      %i[
        01234567
        0123
        012345
        012-3456
      ].each do |post_code|
        context '不正なpost_codeの場合' do
          before :each do
            subject.post_code = post_code
          end

          it 'バリデーションに落ちること' do
            expect(subject).to be_invalid
          end

          it 'バリデーションのエラーが正しいこと' do
            subject.valid?
            expect(subject.errors.full_messages).to include('郵便番号は不正な値です')
          end
        end
      end
    end

    describe '#phone_number' do
      context '存在しない場合' do
        before :each do
          subject.phone_number = nil
        end

        it 'バリデーションが通ること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('電話番号を入力してください')
        end
      end

      %i[
        012345678987
        012345678
        012-3456-7898
        012/3456/7898
      ].each do |phone_number|
        context '不正なphone_numberの場合' do
          before :each do
            subject.phone_number = phone_number
          end

          it 'バリデーションに落ちること' do
            expect(subject).to be_invalid
          end

          it 'バリデーションのエラーが正しいこと' do
            subject.valid?
            expect(subject.errors.full_messages).to include('電話番号は不正な値です')
          end
        end
      end
    end

    describe '#business_type' do
      context '存在しない場合' do
        before :each do
          subject.business_type = nil
        end

        it 'バリデーションが通ること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('会社形態を入力してください')
        end
      end
    end
  end

  describe '車両とのアソシエーションについて' do
    let :business do
      create(:business, cars: cars)
    end

    let :cars do
      create_list(:car, 2)
    end

    context '紐つく車両がある場合' do
      subject do
        business.cars
      end

      it '紐つく車両を返すこと' do
        expect(subject).to eq(cars)
      end
    end
  end

  describe '発注とのアソシエーションについて' do
    let :business do
      create(:business, orders: orders)
    end

    let :orders do
      create_list(:order, 2)
    end

    context '紐つく発注がある場合' do
      subject do
        business.orders
      end

      it '紐つく発注を返すこと' do
        expect(subject).to eq(orders)
      end
    end
  end
end

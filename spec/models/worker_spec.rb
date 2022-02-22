require 'rails_helper'

RSpec.describe Worker, type: :model do
  let(:business) { create(:business) }
  let :worker do
    build(:worker)
  end

  describe 'バリデーションについて' do
    subject do
      worker
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
          expect(subject.errors.full_messages).to include('名前を入力してください')
        end
      end
    end

    describe '#name_kana' do
      context '存在しない場合' do
        before :each do
          subject.name_kana = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('名前カナを入力してください')
        end

        %i[
          てすとわーかー
          TestWorker
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
              expect(subject.errors.full_messages).to include('名前カナはカタカナで入力してください')
            end
          end
        end
      end
    end

    describe '#country' do
      context '存在しない場合' do
        before :each do
          subject.country = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('国籍を入力してください')
        end
      end
    end

    describe '#my_address' do
      context '存在しない場合' do
        before :each do
          subject.my_address = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('住所を入力してください')
        end
      end
    end

    describe '#my_phone_number' do
      context '存在しない場合' do
        before :each do
          subject.my_phone_number = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('電話番号を入力してください')
        end

        %i[
          123456789
          123456789012
          123-4567-8901
          123/4567/8901
        ].each do |my_phone_number|
          context '不正なmy_phone_numberの場合' do
            before :each do
              subject.my_phone_number = my_phone_number
            end

            it 'バリデーションに落ちること' do
              expect(subject).to be_invalid
            end

            it 'バリデーションのエラーが正しいこと' do
              subject.valid?
              expect(subject.errors.full_messages).to include('電話番号はハイフン無しの10桁または11桁で入力してください')
            end
          end
        end
      end
    end

    describe '#family_address' do
      context '存在しない場合' do
        before :each do
          subject.family_address = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('家族住所を入力してください')
        end
      end
    end

    describe '#family_phone_number' do
      context '存在しない場合' do
        before :each do
          subject.family_phone_number = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('家族電話番号を入力してください')
        end

        %i[
          123456789
          123456789012
          123-4567-8901
          123/4567/8901
        ].each do |family_phone_number|
          context '不正なfamily_phone_numberの場合' do
            before :each do
              subject.family_phone_number = family_phone_number
            end

            it 'バリデーションに落ちること' do
              expect(subject).to be_invalid
            end

            it 'バリデーションのエラーが正しいこと' do
              subject.valid?
              expect(subject.errors.full_messages).to include('家族電話番号はハイフン無しの10桁または11桁で入力してください')
            end
          end
        end
      end
    end

    describe '#birth_day_on' do
      context '存在しない場合' do
        before :each do
          subject.birth_day_on = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('生年月日を入力してください')
        end
      end
    end

    describe '#abo_blood_type' do
      context '存在しない場合' do
        before :each do
          subject.abo_blood_type = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('血液型(ABO)を入力してください')
        end
      end
    end

    describe '#rh_blood_type' do
      context '存在しない場合' do
        before :each do
          subject.rh_blood_type = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('血液型(Rh)を入力してください')
        end
      end
    end

    describe '#job_type' do
      context '存在しない場合' do
        before :each do
          subject.job_type = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('職種を入力してください')
        end
      end
    end

    describe '#hiring_on' do
      context '存在しない場合' do
        before :each do
          subject.hiring_on = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('雇入年月日を入力してください')
        end
      end
    end

    describe '#experience_term_before_hiring' do
      context '存在しない場合' do
        before :each do
          subject.experience_term_before_hiring = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('雇入前経験年数を入力してください')
        end
      end
    end

    describe '#blank_term' do
      context '存在しない場合' do
        before :each do
          subject.blank_term = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('ブランク年数を入力してください')
        end
      end
    end
  end

  describe '保険会社とのアソシエーションについて' do
    let :worker_insurance do
      create(:worker_insurance, worker: worker)
    end

    context '紐つく保険会社がある場合' do
      subject do
        worker.worker_insurance
      end

      before(:each) do
        worker_insurance.save!
      end

      it '紐つく保険会社を返すこと' do
        expect(subject).to eq(worker_insurance)
      end
    end
  end
end

require 'rails_helper'

RSpec.describe WorkerLicense, type: :model do
  let(:worker) { create(:worker) }
  let(:license) { create(:license) }
  let :worker_license do
    create(:worker_license, worker: worker, license: license)
  end

  describe 'バリデーションについて' do
    subject do
      worker_license
    end

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    describe '#got_on' do
      context '存在しない場合' do
        before :each do
          subject.got_on = ''
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('取得年月日を入力してください')
        end
      end
    end

    describe '#worker_id' do
      context '存在しない場合' do
        before :each do
          subject.worker_id = ''
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('Workerを入力してください')
        end
      end
    end

    describe '#license_id' do
      context '存在しない場合' do
        before :each do
          subject.license_id = ''
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('Licenseを入力してください')
        end
      end
    end
  end

  describe 'アソシエーションについて' do
    context '紐づく作業員がいる場合' do
      subject do
        worker_license.worker
      end

      it '紐づく作業員を返すこと' do
        expect(subject).to eq(worker)
      end
    end

    context '紐づく免許マスタがある場合' do
      subject do
        worker_license.license
      end

      it '紐づく免許マスタを返すこと' do
        expect(subject).to eq(license)
      end
    end
  end
end

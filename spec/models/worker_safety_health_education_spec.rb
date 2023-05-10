require 'rails_helper'

RSpec.describe WorkerSafetyHealthEducation, type: :model do
  let(:worker) { create(:worker) }
  let(:safety_health_education) { create(:safety_health_education) }
  let :worker_safety_health_education do
    create(:worker_safety_health_education, worker: worker, safety_health_education: safety_health_education, images: [Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg'))])
  end

  describe 'バリデーションについて' do
    subject do
      worker_safety_health_education
    end

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
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

    describe '#safety_health_education' do
      context '存在しない場合' do
        before :each do
          subject.safety_health_education_id = ''
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('Safety health educationを入力してください')
        end
      end
    end
  end

  describe 'アソシエーションについて' do
    context '紐づく作業員がいる場合' do
      subject do
        worker_safety_health_education.worker
      end

      it '紐づく作業員を返すこと' do
        expect(subject).to eq(worker)
      end
    end

    context '紐づく特別教育マスタがある場合' do
      subject do
        worker_safety_health_education.safety_health_education
      end

      it '紐づく特別教育マスタを返すこと' do
        expect(subject).to eq(safety_health_education)
      end
    end
  end
end

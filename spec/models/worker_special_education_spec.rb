require 'rails_helper'

RSpec.describe WorkerSkillTraining, type: :model do
  let(:worker) { create(:worker) }
  let(:special_education) { create(:special_education) }
  let :worker_special_education do
    create(:worker_special_education, worker: worker, special_education: special_education, images: [Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpg'))])
  end

  describe 'バリデーションについて' do
    subject do
      worker_special_education
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

    describe '#skill_training_id' do
      context '存在しない場合' do
        before :each do
          subject.special_education_id = ''
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('Special educationを入力してください')
        end
      end
    end
  end

  describe 'アソシエーションについて' do
    context '紐づく作業員がいる場合' do
      subject do
        worker_special_education.worker
      end

      it '紐づく作業員を返すこと' do
        expect(subject).to eq(worker)
      end
    end

    context '紐づく特別教育マスタがある場合' do
      subject do
        worker_special_education.special_education
      end

      it '紐づく特別教育マスタを返すこと' do
        expect(subject).to eq(special_education)
      end
    end
  end
end

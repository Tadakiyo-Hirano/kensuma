require 'rails_helper'

RSpec.describe WorkerSkillTraining, type: :model do
  let(:worker) { create(:worker) }
  let(:skill_training) { create(:skill_training) }
  let :worker_skill_training do
    create(:worker_skill_training, worker: worker, skill_training: skill_training)
  end

  describe 'バリデーションについて' do
    subject do
      worker_skill_training
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

    describe '#skill_training_id' do
      context '存在しない場合' do
        before :each do
          subject.skill_training_id = ''
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('Skill trainingを入力してください')
        end
      end
    end
  end

  describe 'アソシエーションについて' do
    context '紐づく作業員がいる場合' do
      subject do
        worker_skill_training.worker
      end

      it '紐づく作業員を返すこと' do
        expect(subject).to eq(worker)
      end
    end

    context '紐づく技能講習マスタがある場合' do
      subject do
        worker_skill_training.skill_training
      end

      it '紐づく技能講習マスタを返すこと' do
        expect(subject).to eq(skill_training)
      end
    end
  end
end

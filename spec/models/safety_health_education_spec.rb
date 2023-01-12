require 'rails_helper'

RSpec.describe SafetyHealthEducation, type: :model do
  let(:safety_health_education) { create(:safety_health_education) }

  describe 'バリデーションについて' do
    subject { safety_health_education }

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    describe '#name' do
      context '存在しない場合' do
        before(:each) { subject.name = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end
  end
end

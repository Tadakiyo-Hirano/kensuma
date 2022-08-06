require 'rails_helper'

RSpec.describe Machine, type: :model do
  let :machine do
    build(:machine)
  end

  describe 'バリデーションテスト' do
    subject do
      machine
    end

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
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

      it 'バリデーションエラーが正しいこと' do
        subject.valid?
        expect(subject.errors.full_messages).to include('機械名を入力してください')
      end
    end
  end

  describe '#standards_performance' do
    context '存在しない場合' do
      before :each do
        subject.standards_performance = nil
      end

      it 'バリデーションに落ちること' do
        expect(subject).to be_invalid
      end

      it 'バリデーションエラーが正しいこと' do
        subject.valid?
        expect(subject.errors.full_messages).to include('規格・性能を入力してください')
      end
    end
  end

  describe '#control_number' do
    context '存在しない場合' do
      before :each do
        subject.control_number = nil
      end

      it 'バリデーションに落ちること' do
        expect(subject).to be_invalid
      end

      it 'バリデーションエラーが正しいこと' do
        subject.valid?
        expect(subject.errors.full_messages).to include('管理番号を入力してください')
      end
    end
  end

  describe '#inspector' do
    context '存在しない場合' do
      before :each do
        subject.inspector = nil
      end

      it 'バリデーションに落ちること' do
        expect(subject).to be_invalid
      end

      it 'バリデーションエラーが正しいこと' do
        subject.valid?
        expect(subject.errors.full_messages).to include('取扱者を入力してください')
      end
    end
  end

  describe '#handler' do
    context '存在しない場合' do
      before :each do
        subject.handler = nil
      end

      it 'バリデーションに落ちること' do
        expect(subject).to be_invalid
      end

      it 'バリデーションエラーが正しいこと' do
        subject.valid?
        expect(subject.errors.full_messages).to include('取扱者を入力してください')
      end
    end
  end

  describe '#inspection_date' do
    context '存在しない場合' do
      before :each do
        subject.inspection_date = nil
      end

      it 'バリデーションに落ちること' do
        expect(subject).to be_invalid
      end

      it 'バリデーションエラーが正しいこと' do
        subject.valid?
        expect(subject.errors.full_messages).to include('点検年月日を入力してください')
      end
    end
  end
end

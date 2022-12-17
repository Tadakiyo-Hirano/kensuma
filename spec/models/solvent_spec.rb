require 'rails_helper'

RSpec.describe Solvent, type: :model do
  let :solvent do
    build(:solvent)
  end

  describe 'バリデーションについて' do
    subject do
      solvent
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
          expect(subject.errors.full_messages).to include('商品名を入力してください')
        end
      end
    end

    describe '#classification' do
      context '存在しない場合' do
        before :each do
          subject.classification = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('種別を入力してください')
        end
      end
    end

    describe '#ingredients' do
      context '存在しない場合' do
        before :each do
          subject.ingredients = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('含有成分を入力してください')
        end
      end
    end
  end
end

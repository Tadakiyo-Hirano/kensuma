require 'rails_helper'

RSpec.describe Solvent, type: :model do
  let(:business) { FactoryBot.create(:business) }

  describe 'バリデーションについて' do
    subject(:solvent) { build(:solvent, business: business) }

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    describe '#name' do
      subject { FactoryBot.build(:solvent, business: business) }

      let(:business) { FactoryBot.build(:business) }

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

      context '同じビジネス内で既に存在する場合' do
        before :each do
          create(:solvent, name: 'TEST塗料液', business: business)
          subject.name = 'TEST塗料液'
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('商品名はすでに存在します')
        end
      end
    end

    describe '#maker' do
      context '存在しない場合' do
        before :each do
          subject.maker = nil
        end

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end

        it 'バリデーションのエラーが正しいこと' do
          subject.valid?
          expect(subject.errors.full_messages).to include('メーカー名を入力してください')
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

require 'rails_helper'

RSpec.describe FieldSolvent, type: :model do
  let(:order_field_solvent) { build(:order_field_solvent) }
  let(:request_order_field_solvent) { build(:request_order_field_solvent) }

  describe 'order側バリデーションについて' do
    subject { order_field_solvent }

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end
  end

  describe 'request_order側バリデーションについて' do
    subject { request_order_field_solvent }

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end
  end
end

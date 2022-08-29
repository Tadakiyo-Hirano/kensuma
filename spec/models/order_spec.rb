require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { create(:order) }

  describe 'バリデーションについて' do
    subject { order }

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    describe '#status' do
      context '存在しない場合' do
        before(:each) { subject.status = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
          subject.valid?
          expect(subject.errors.full_messages).to include('ステータスを入力してください')
        end
      end
    end

    describe '#site_uu_id' do
      context '存在しない場合' do
        before(:each) { subject.site_uu_id = nil }

        it 'バリデーションに落ちること' do
          expect(subject.site_uu_id).to be_falsey
        end
      end
    end

    describe '#site_name' do
      context '存在しない場合' do
        before(:each) { subject.site_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject.site_name).to be_falsey
        end
      end
    end

    describe '#site_address' do
      context '存在しない場合' do
        before(:each) { subject.site_address = nil }

        it 'バリデーションに落ちること' do
          expect(subject.site_address).to be_falsey
        end
      end
    end

    describe '#order_name' do
      context '存在しない場合' do
        before(:each) { subject.order_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject.order_name).to be_falsey
        end
      end
    end

    describe '#order_post_code' do
      context '存在しない場合' do
        before(:each) { subject.order_post_code = nil }

        it 'バリデーションに落ちること' do
          expect(subject.order_post_code).to be_falsey
        end
      end

      %i[
        01234567
        0123
        012345
        012-3456
      ].each do |order_post_code|
        context '不正なpost_codeの場合' do
          before :each do
            subject.order_post_code = order_post_code
          end

          it 'バリデーションに落ちること' do
            expect(subject).to be_invalid
            subject.valid?
            expect(subject.errors.full_messages).to include('郵便番号は不正な値です')
          end
        end
      end
    end

    describe '#order_address' do
      context '存在しない場合' do
        before(:each) { subject.order_address = nil }

        it 'バリデーションに落ちること' do
          expect(subject.order_address).to be_falsey
        end
      end
    end

    describe '#order_supervisor_name' do
      context '存在しない場合' do
        before(:each) { subject.order_supervisor_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject.order_supervisor_name).to be_falsey
        end
      end
    end

    describe '#order_supervisor_apply' do
      context '存在しない場合' do
        before(:each) { subject.order_supervisor_apply = nil }

        it 'バリデーションに落ちること' do
          expect(subject.order_supervisor_apply).to be_falsey
        end
      end
    end

    describe '#construction_name' do
      context '存在しない場合' do
        before(:each) { subject.construction_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject.construction_name).to be_falsey
        end
      end
    end

    describe '#construction_details' do
      context '存在しない場合' do
        before(:each) { subject.construction_details = nil }

        it 'バリデーションに落ちること' do
          expect(subject.construction_details).to be_falsey
        end
      end
    end

    describe '#submission_destination' do
      context '存在しない場合' do
        before(:each) { subject.submission_destination = nil }

        it 'バリデーションに落ちること' do
          expect(subject.submission_destination).to be_falsey
        end
      end
    end

    describe '#general_safety_responsible_person_name' do
      context '存在しない場合' do
        before(:each) { subject.general_safety_responsible_person_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject.general_safety_responsible_person_name).to be_falsey
        end
      end
    end

    describe '#vice_president_name' do
      context '存在しない場合' do
        before(:each) { subject.vice_president_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject.vice_president_name).to be_falsey
        end
      end
    end

    describe '#vice_president_company_name' do
      context '存在しない場合' do
        before(:each) { subject.vice_president_company_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject.vice_president_company_name).to be_falsey
        end
      end
    end

    describe '#secretary_name' do
      context '存在しない場合' do
        before(:each) { subject.secretary_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject.secretary_name).to be_falsey
        end
      end
    end

    describe '#health_and_safety_manager_name' do
      context '存在しない場合' do
        before(:each) { subject.health_and_safety_manager_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject.health_and_safety_manager_name).to be_falsey
        end
      end
    end

    describe '#general_safety_agent_name' do
      context '存在しない場合' do
        before(:each) { subject.general_safety_agent_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject.general_safety_agent_name).to be_falsey
        end
      end
    end

    describe '#supervisor_name' do
      context '存在しない場合' do
        before(:each) { subject.supervisor_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject.supervisor_name).to be_falsey
        end
      end
    end

    describe '#supervisor_apply' do
      context '存在しない場合' do
        before(:each) { subject.supervisor_apply = nil }

        it 'バリデーションに落ちること' do
          expect(subject.supervisor_apply).to be_falsey
        end
      end
    end

    describe '#site_agent_name' do
      context '存在しない場合' do
        before(:each) { subject.site_agent_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject.site_agent_name).to be_falsey
        end
      end
    end

    describe '#site_agent_apply' do
      context '存在しない場合' do
        before(:each) { subject.site_agent_apply = nil }

        it 'バリデーションに落ちること' do
          expect(subject.site_agent_apply).to be_falsey
        end
      end
    end

    describe '#supervising_engineer_name' do
      context '存在しない場合' do
        before(:each) { subject.supervising_engineer_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject.supervising_engineer_name).to be_falsey
        end
      end
    end

    describe '#supervising_engineer_check' do
      context '存在しない場合' do
        before(:each) { subject.supervising_engineer_check = nil }

        it 'バリデーションに落ちること' do
          expect(subject.supervising_engineer_check).to be_falsey
        end
      end
    end

    describe '#safety_officer_name' do
      context '存在しない場合' do
        before(:each) { subject.safety_officer_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject.safety_officer_name).to be_falsey
        end
      end
    end

    describe '#safety_officer_position_name' do
      context '存在しない場合' do
        before(:each) { subject.safety_officer_position_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject.safety_officer_position_name).to be_falsey
        end
      end
    end

    describe '#confirm_name' do
      context '存在しない場合' do
        before(:each) { subject.confirm_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject.confirm_name).to be_falsey
        end
      end
    end

    describe '#subcontractor_name' do
      context '存在しない場合' do
        before(:each) { subject.subcontractor_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject.subcontractor_name).to be_falsey
        end
      end
    end
  end

  describe '下請発注情報とのアソシエーションについて' do
    context '紐つく下請発注情報がある場合' do
      subject do
        order.request_orders
      end

      let :request_orders do
        create_list(:request_order, 2, order: order)
      end

      it '紐つく下請発注情報を返すこと' do
        expect(subject).to eq(request_orders)
      end
    end
  end
end

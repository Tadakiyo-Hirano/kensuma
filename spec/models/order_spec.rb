require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { create(:order) }

  describe 'バリデーションについて' do
    subject { order }

    it 'バリデーションが通ること' do
      expect(subject).to be_valid
    end

    # describe '#status' do
    #   context '存在しない場合' do
    #     before(:each) { subject.status = nil }

    #     it 'バリデーションに落ちること' do
    #       expect(subject).to be_invalid
    #       subject.valid?
    #       expect(subject.errors.full_messages).to include('ステータスを入力してください')
    #     end
    #   end
    # end

    describe '#site_uu_id' do
      context '存在しない場合' do
        before(:each) { subject.site_uu_id = nil }

        it 'バリデーションに落ちること' do
          expect(subject.site_uu_id).to be_falsey
        end
      end
    end

    # 現場
    describe '#site_career_up_id' do
      context 'nilの場合' do
        before(:each) { subject.site_career_up_id = nil }

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end
      end

      context '数値14桁の場合' do
        before(:each) { subject.site_career_up_id = '0' * 14 }

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end
      end

      context '数値14桁以上の場合' do
        before(:each) { subject.site_career_up_id = '0' * 15 }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end

      %i[
        'aaa'
        'ひらがな'
        'ｶﾀｶﾅ'
        '@+-'
      ].each do |site_career_up_id|
        context '数値以外の場合' do
          before :each do
            subject.site_career_up_id = site_career_up_id
          end

          it 'バリデーションに落ちること' do
            expect(subject).to be_invalid
          end
        end
      end
    end

    describe '#site_name' do
      context '存在しない場合' do
        before(:each) { subject.site_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end

      context '文字数が100文字の場合' do
        before(:each) { subject.site_name = 'a' * 100 }

        it 'バリデーションに通ること' do
          expect(subject).to be_valid
        end
      end

      context '文字数が101文字以上の場合' do
        before(:each) { subject.site_name = 'a' * 101 }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#site_address' do
      context '存在しない場合' do
        before(:each) { subject.site_address = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end

      context '50文字の場合' do
        before(:each) { subject.site_address = 'a' * 50 }

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end
      end

      context '50文字以上の場合' do
        before(:each) { subject.site_address = 'a' * 51 }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    # 発注者
    describe '#order_name' do
      context '存在しない場合' do
        before(:each) { subject.order_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#order_post_code' do
      context '存在しない場合' do
        before(:each) { subject.order_post_code = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
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
            expect(subject.errors.full_messages).to include('郵便番号(発注者)は不正な値です')
          end
        end
      end
    end

    describe '#order_address' do
      context '存在しない場合' do
        before(:each) { subject.order_address = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#order_supervisor_name' do
      context '存在しない場合' do
        before(:each) { subject.order_supervisor_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#order_supervisor_apply' do
      context '存在しない場合' do
        before(:each) { subject.order_supervisor_apply = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end

      context '40文字の場合' do
        before(:each) { subject.order_supervisor_apply = 'a' * 40 }

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end
      end

      context '41文字以上の場合' do
        before(:each) { subject.order_supervisor_apply = 'a' * 41 }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    # 元請会社
    describe '#construction_name' do
      context '存在しない場合' do
        before(:each) { subject.construction_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#start_date' do
      context '存在しない場合' do
        before(:each) { subject.start_date = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#end_date' do
      context '存在しない場合' do
        before(:each) { subject.end_date = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#contract_date' do
      context '存在しない場合' do
        before(:each) { subject.contract_date = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#site_agent_name' do
      context '存在しない場合' do
        before(:each) { subject.site_agent_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#site_agent_apply' do
      context '存在しない場合' do
        before(:each) { subject.site_agent_apply = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end

      context '40文字の場合' do
        before(:each) { subject.site_agent_apply = 'a' * 40 }

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end
      end

      context '41文字以上の場合' do
        before(:each) { subject.site_agent_apply = 'a' * 41 }

        it 'バリデーションが通ること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#supervisor_name' do
      context '存在しない場合' do
        before(:each) { subject.supervisor_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#supervisor_apply' do
      context '存在しない場合' do
        before(:each) { subject.supervisor_apply = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end

      context '40文字の場合' do
        before(:each) { subject.supervisor_apply = 'a' * 40 }

        it 'バリデーションが通ること' do
          expect(subject).to be_valid
        end
      end

      context '41文字の場合' do
        before(:each) { subject.supervisor_apply = 'a' * 41 }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    # describe 'professional_engineer_construction_details' do
    #   context '40文字の場合' do
    #     before(:each) { subject.professional_engineer_construction_details = 'a' * 40 }

    #     it 'バリデーションが通ること' do
    #       expect(subject).to be_valid
    #     end
    #   end

    #   context '41文字の場合' do
    #     before(:each) { subject.professional_engineer_construction_details = 'a' * 41 }

    #     it 'バリデーションに落ちること' do
    #       expect(subject).to be_invalid
    #     end
    #   end
    # end

    # describe '#general_safety_responsible_person_name' do
    #   context '存在しない場合' do
    #     before(:each) { subject.general_safety_responsible_person_name = nil }

    #     it 'バリデーションに落ちること' do
    #       expect(subject).to be_invalid
    #     end
    #   end
    # end

    # describe '#general_safety_agent_name' do
    #   context '存在しない場合' do
    #     before(:each) { subject.general_safety_agent_name = nil }

    #     it 'バリデーションに落ちること' do
    #       expect(subject).to be_invalid
    #     end
    #   end
    # end

    describe '#supervising_engineer_name' do
      context '存在しない場合' do
        before(:each) { subject.supervising_engineer_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#supervising_engineer_check' do
      context '存在しない場合' do
        before(:each) { subject.supervising_engineer_check = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    describe '#submission_destination' do
      context '存在しない場合' do
        before(:each) { subject.submission_destination = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    # # 年間安全計画書
    # describe '#safety_officer_name' do
    #   context '存在しない場合' do
    #     before(:each) { subject.safety_officer_name = nil }

    #     it 'バリデーションに落ちること' do
    #       expect(subject).to be_invalid
    #     end
    #   end
    # end

    # describe '#safety_officer_position_name' do
    #   context '存在しない場合' do
    #     before(:each) { subject.safety_officer_position_name = nil }

    #     it 'バリデーションに落ちること' do
    #       expect(subject).to be_invalid
    #     end
    #   end
    # end

    # # 工事作業所災害防止協議会兼施工体系図
    # describe '#vice_president_name' do
    #   context '存在しない場合' do
    #     before(:each) { subject.vice_president_name = nil }

    #     it 'バリデーションに落ちること' do
    #       expect(subject).to be_invalid
    #     end
    #   end
    # end

    # describe '#vice_president_company_name' do
    #   context '存在しない場合' do
    #     before(:each) { subject.vice_president_company_name = nil }

    #     it 'バリデーションに落ちること' do
    #       expect(subject).to be_invalid
    #     end
    #   end
    # end

    # describe '#secretary_name' do
    #   context '存在しない場合' do
    #     before(:each) { subject.secretary_name = nil }

    #     it 'バリデーションに落ちること' do
    #       expect(subject).to be_invalid
    #     end
    #   end
    # end

    describe '#health_and_safety_manager_name' do
      context '存在しない場合' do
        before(:each) { subject.health_and_safety_manager_name = nil }

        it 'バリデーションに落ちること' do
          expect(subject).to be_invalid
        end
      end
    end

    # 認証
    # describe '#confirm_name' do
    #   context '存在しない場合' do
    #     before(:each) { subject.confirm_name = nil }

    #     it 'バリデーションに落ちること' do
    #       expect(subject).to be_invalid
    #     end
    #   end
    # end

    # describe '#subcontractor_name' do
    #   context '存在しない場合' do
    #     before(:each) { subject.subcontractor_name = nil }

    #     it 'バリデーションに落ちること' do
    #       expect(subject).to be_invalid
    #     end
    #   end
    # end
  end

  describe '下請発注情報とのアソシエーションについて' do
    context '紐づく下請発注情報がある場合' do
      subject do
        order.request_orders
      end

      let :request_orders do
        create_list(:request_order, 2, order: order)
      end

      it '紐づく下請発注情報を返すこと' do
        expect(subject).to eq(request_orders)
      end
    end
  end
end

FactoryBot.define do
  factory :request_order do
    uuid { SecureRandom.uuid }
    status { 0 }
    sequence(:construction_name) { |n| "construction_name#{n}" }
    sequence(:construction_details) { |n| "construction_details#{n}" }
    start_date { '2022-01-01' }
    end_date { '2022-01-01' }
    contract_date { '2022-01-01' }
    sequence(:site_agent_name) { |n| "site_agent_name#{n}" }
    sequence(:site_agent_apply) { |n| "site_agent_apply#{n}" }
    sequence(:supervisor_name) { |n| "supervisor_name#{n}" }
    sequence(:supervisor_apply) { |n| "supervisor_apply#{n}" }
    sequence(:professional_engineer_name) { |n| "professional_engineer_name#{n}" }
    sequence(:professional_engineer_details) { |n| "professional_engineer_details#{n}" }
    professional_construction { 0 }
    sequence(:construction_manager_name) { |n| "construction_manager_name#{n}" }
    sequence(:construction_manager_position_name) { |n| "construction_manager_position_name#{n}" }
    sequence(:lead_engineer_name) { |n| "lead_engineer_name#{n}" }
    lead_engineer_check { 0 }
    sequence(:work_chief_name) { |n| "work_chief_name#{n}" }
    sequence(:work_conductor_name) { |n| "work_conductor_name#{n}" }
    sequence(:safety_officer_name) { |n| "safety_officer_name#{n}" }
    sequence(:safety_manager_name) { |n| "safety_manager_name#{n}" }
    sequence(:safety_promoter_name) { |n| "safety_promoter_name#{n}" }
    sequence(:foreman_name) { |n| "foreman_name#{n}" }
    sequence(:registered_core_engineer_name) { |n| "registered_core_engineer_name#{n}" }
    order
    business
  end
end

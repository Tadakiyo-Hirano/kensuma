FactoryBot.define do
  factory :order do
    site_uu_id { SecureRandom.uuid }
    site_career_up_id { 12345678901234 }
    sequence(:site_name) { |n| "site_name#{n}" }
    sequence(:site_address) { |n| "site_address#{n}" }
    sequence(:order_name) { |n| "order_name#{n}" }
    order_post_code { '1000014' }
    sequence(:order_address) { |n| "order_address#{n}" }
    sequence(:order_supervisor_name) { |n| "order_supervisor_name#{n}" }
    sequence(:order_supervisor_company) { |n| "order_supervisor_company#{n}" }
    sequence(:order_supervisor_apply) { |n| "order_supervisor_apply#{n}" }
    sequence(:construction_name) { |n| "construction_name#{n}" }
    sequence(:construction_details) { |n| "construction_details#{n}" }
    start_date { '2022-01-01' }
    end_date { '2022-01-01' }
    contract_date { '2022-01-01' }
    sequence(:site_agent_name) { |n| "site_agent_name#{n}" }
    sequence(:site_agent_apply) { |n| "site_agent_apply#{n}" }
    sequence(:supervisor_name) { |n| "supervisor_name#{n}" }
    sequence(:supervisor_apply) { |n| "supervisor_apply#{n}" }
    sequence(:supervising_engineer_name) { |n| "supervising_engineer_name#{n}" }
    supervising_engineer_check { 0 }
    sequence(:supervising_engineer_assistant_name) { |n| "supervising_engineer_assistant_name#{n}" }
    sequence(:general_safety_responsible_person_name) { |n| "general_safety_responsible_person_name#{n}" }
    sequence(:general_safety_agent_name) { |n| "general_safety_agent_name#{n}" }
    sequence(:health_and_safety_manager_name) { |n| "health_and_safety_manager_name#{n}" }
    sequence(:submission_destination) { |n| "submission_destination#{n}" }
    # sequence(:vice_president_name) { |n| "vice_president_name#{n}" }
    # sequence(:vice_president_company_name) { |n| "vice_president_company_name#{n}" }
    # sequence(:secretary_name) { |n| "secretary_name#{n}" }
    # sequence(:professional_engineer_name) { |n| "professional_engineer_name#{n}" }
    # sequence(:professional_engineer_construction_details) { |n| "details#{n}" }
    # sequence(:safety_officer_name) { |n| "safety_officer_name#{n}" }
    # sequence(:safety_officer_position_name) { |n| "safety_officer_position_name#{n}" }
    # sequence(:general_safety_manager_name) { |n| "general_safety_manager_name#{n}" }
    # sequence(:general_safety_manager_position_name) { |n| "general_safety_manager_position_name#{n}" }
    # sequence(:safety_manager_name) { |n| "safety_manager_name#{n}" }
    # sequence(:safety_manager_position_name) { |n| "safety_manager_position_name#{n}" }
    # sequence(:health_manager_name) { |n| "health_manager_name#{n}" }
    # sequence(:health_manager_position_name) { |n| "health_manager_position_name#{n}" }
    # sequence(:health_and_safety_promoter_name) { |n| "health_and_safety_promoter_name#{n}" }
    # sequence(:health_and_safety_promoter_position_name) { |n| "health_and_safety_promoter_position_name#{n}" }
    # sequence(:confirm_name) { |n| "confirm_name#{n}" }
    # accept_confirm_date { '2022-01-01' }
    # sequence(:subcontractor_name) { |n| "subcontractor_name#{n}" }
    business
  end
end

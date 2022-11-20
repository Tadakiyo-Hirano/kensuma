# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 2022_10_31_124925) do
=======
ActiveRecord::Schema.define(version: 2022_11_05_031631) do
>>>>>>> main

  create_table "active_admin_comments", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admins", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.index ["confirmation_token"], name: "index_admins_on_confirmation_token", unique: true
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_admins_on_unlock_token", unique: true
  end

  create_table "articles", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "title", null: false
    t.string "sub_title"
    t.text "content", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_articles_on_user_id"
  end

  create_table "business_industries", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "business_id", null: false
    t.bigint "industry_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_id"], name: "index_business_industries_on_business_id"
    t.index ["industry_id"], name: "index_business_industries_on_industry_id"
  end

  create_table "business_occupations", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "business_id", null: false
    t.bigint "occupation_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_id"], name: "index_business_occupations_on_business_id"
    t.index ["occupation_id"], name: "index_business_occupations_on_occupation_id"
  end

  create_table "businesses", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "name", null: false
    t.string "name_kana", null: false
    t.string "branch_name", null: false
    t.string "representative_name", null: false
    t.string "email", null: false
    t.string "address", null: false
    t.string "post_code", null: false
    t.string "phone_number", null: false
    t.string "carrier_up_id"
    t.json "stamp_images"
    t.integer "business_type", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "business_health_insurance_status", null: false
    t.string "business_health_insurance_association"
    t.string "business_health_insurance_office_number"
    t.integer "business_welfare_pension_insurance_join_status", null: false
    t.string "business_welfare_pension_insurance_office_number"
    t.integer "business_pension_insurance_join_status", null: false
    t.integer "business_employment_insurance_join_status", null: false
    t.string "business_employment_insurance_number"
    t.integer "business_retirement_benefit_mutual_aid_status", null: false
    t.integer "construction_license_status", null: false
    t.integer "construction_license_permission_type_minister_governor"
    t.integer "construction_license_governor_permission_prefecture"
    t.integer "construction_license_permission_type_identification_general"
    t.string "construction_license_number_double_digit"
    t.string "construction_license_number_six_digits"
    t.string "construction_license_number"
    t.date "construction_license_updated_at"
    t.index ["user_id"], name: "index_businesses_on_user_id"
  end

  create_table "car_insurance_companies", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "car_voluntary_insurances", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.integer "personal_insurance"
    t.integer "objective_insurance"
    t.bigint "car_voluntary_id", null: false
    t.bigint "company_voluntary_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "voluntary_securities_number"
    t.date "voluntary_insurance_start_on"
    t.date "voluntary_insurance_end_on"
    t.index ["car_voluntary_id"], name: "index_car_voluntary_insurances_on_car_voluntary_id"
    t.index ["company_voluntary_id"], name: "index_car_voluntary_insurances_on_company_voluntary_id"
  end

  create_table "cars", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "owner_name", null: false
    t.string "safety_manager"
    t.string "vehicle_model", null: false
    t.string "vehicle_number", null: false
    t.date "vehicle_inspection_start_on", null: false
    t.date "vehicle_inspection_end_on", null: false
    t.string "liability_securities_number", null: false
    t.date "liability_insurance_start_on", null: false
    t.date "liability_insurance_end_on", null: false
    t.json "images"
    t.bigint "business_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "car_insurance_company_id", null: false
    t.string "uuid", null: false
    t.integer "usage", null: false
    t.string "vehicle_name", null: false
    t.index ["business_id"], name: "index_cars_on_business_id"
    t.index ["car_insurance_company_id"], name: "index_cars_on_car_insurance_company_id"
  end

  create_table "documents", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.integer "document_type"
    t.date "created_on"
    t.date "submitted_on"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "uuid", null: false
    t.json "content"
    t.bigint "business_id", null: false
    t.bigint "request_order_id", null: false
    t.index ["business_id"], name: "index_documents_on_business_id"
    t.index ["request_order_id"], name: "index_documents_on_request_order_id"
  end

  create_table "field_cars", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "car_name", null: false
    t.json "content", null: false
    t.string "driver_name"
    t.date "usage_period_start"
    t.date "usage_period_end"
    t.string "starting_point"
    t.string "waypoint_first"
    t.string "waypoint_second"
    t.string "arrival_point"
    t.string "field_carable_type"
    t.bigint "field_carable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "driver_worker_id"
    t.string "driver_address"
    t.date "driver_birth_day_on"
    t.index ["field_carable_type", "field_carable_id"], name: "index_field_cars_on_field_carable"
  end

  create_table "field_fire_fire_managements", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "field_fire_id", null: false
    t.bigint "fire_management_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["field_fire_id"], name: "index_field_fire_fire_managements_on_field_fire_id"
    t.index ["fire_management_id"], name: "index_field_fire_fire_managements_on_fire_management_id"
  end

  create_table "field_fire_fire_types", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "field_fire_id", null: false
    t.bigint "fire_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["field_fire_id"], name: "index_field_fire_fire_types_on_field_fire_id"
    t.index ["fire_type_id"], name: "index_field_fire_fire_types_on_fire_type_id"
  end

  create_table "field_fire_fire_use_targets", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "field_fire_id", null: false
    t.bigint "fire_use_target_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["field_fire_id"], name: "index_field_fire_fire_use_targets_on_field_fire_id"
    t.index ["fire_use_target_id"], name: "index_field_fire_fire_use_targets_on_fire_use_target_id"
  end

  create_table "field_fires", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "use_place", null: false
    t.string "other_use_target"
    t.date "usage_period_start"
    t.date "usage_period_end"
    t.string "other_fire_type"
    t.time "usage_time_start"
    t.time "usage_time_end"
    t.string "precautions"
    t.string "fire_origin_responsible"
    t.string "fire_use_responsible"
    t.string "field_fireable_type"
    t.bigint "field_fireable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["field_fireable_type", "field_fireable_id"], name: "index_field_fires_on_field_fireable"
  end

  create_table "field_machines", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "machine_name", null: false
    t.json "content", null: false
    t.date "carry_on_date"
    t.date "carry_out_date"
    t.text "precautions"
    t.string "field_machineable_type"
    t.bigint "field_machineable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["field_machineable_type", "field_machineable_id"], name: "index_field_machines_on_field_machineable"
  end

  create_table "field_solvents", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "solvent_name", null: false
    t.json "content", null: false
    t.string "carried_quantity"
    t.string "using_location"
    t.string "storing_place"
    t.string "using_tool"
    t.date "usage_period_start"
    t.date "usage_period_end"
    t.integer "working_process"
    t.integer "sds"
    t.string "ventilation_control"
    t.string "field_solventable_type"
    t.bigint "field_solventable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["field_solventable_type", "field_solventable_id"], name: "index_field_solvents_on_field_solventable"
  end

  create_table "field_special_vehicles", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "uuid", null: false
    t.integer "driver_worker_id"
    t.string "driver_name"
    t.string "driver_license"
    t.string "vehicle_name", null: false
    t.json "content", null: false
    t.integer "vehicle_type"
    t.string "carry_on_company_name"
    t.string "owning_company_name"
    t.string "use_company_name"
    t.date "carry_on_date"
    t.date "carry_out_date"
    t.string "use_place"
    t.integer "lease_type"
    t.string "contact_prevention"
    t.string "precautions"
    t.string "field_special_vehicleable_type"
    t.bigint "field_special_vehicleable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["field_special_vehicleable_type", "field_special_vehicleable_id"], name: "index_field_special_vehicles_on_field_special_vehicleable"
  end

  create_table "field_workers", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "admission_worker_name", null: false
    t.json "content", null: false
    t.date "admission_date_start"
    t.date "admission_date_end"
    t.date "education_date"
    t.string "field_workerable_type"
    t.bigint "field_workerable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["field_workerable_type", "field_workerable_id"], name: "index_field_workers_on_field_workerable"
  end

  create_table "fire_managements", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "fire_types", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "fire_use_targets", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "licenses", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.integer "license_type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "machine_tags", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "machine_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["machine_id"], name: "index_machine_tags_on_machine_id"
    t.index ["tag_id"], name: "index_machine_tags_on_tag_id"
  end

  create_table "machines", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "name", null: false
    t.string "standards_performance", null: false
    t.string "control_number", null: false
    t.string "inspector", null: false
    t.string "handler", null: false
    t.date "inspection_date", null: false
    t.string "inspection_check"
    t.bigint "business_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_id"], name: "index_machines_on_business_id"
  end

  create_table "managers", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.index ["confirmation_token"], name: "index_managers_on_confirmation_token", unique: true
    t.index ["email"], name: "index_managers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_managers_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_managers_on_unlock_token", unique: true
  end

  create_table "news", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "title", default: "", null: false
    t.text "content"
    t.datetime "delivered_at"
    t.integer "status", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "uuid", null: false
  end

  create_table "news_users", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "news_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["news_id"], name: "index_news_users_on_news_id"
    t.index ["user_id"], name: "index_news_users_on_user_id"
  end

  create_table "occupations", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "orders", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.string "site_uu_id", null: false
    t.string "site_name", null: false
    t.string "order_name", null: false
    t.string "order_post_code", null: false
    t.string "order_address", null: false
    t.bigint "business_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "site_career_up_id"
    t.string "site_address", null: false
    t.string "order_supervisor_name", null: false
    t.string "order_supervisor_company"
    t.string "order_supervisor_apply", null: false
    t.string "construction_name", null: false
    t.string "construction_details", null: false
    t.date "start_date"
    t.date "end_date"
    t.date "contract_date"
    t.string "submission_destination", null: false
    t.string "general_safety_responsible_person_name", null: false
    t.string "vice_president_name", null: false
    t.string "vice_president_company_name", null: false
    t.string "secretary_name", null: false
    t.string "health_and_safety_manager_name", null: false
    t.string "general_safety_agent_name", null: false
    t.string "supervisor_name", null: false
    t.string "supervisor_apply", null: false
    t.string "site_agent_name", null: false
    t.string "site_agent_apply", null: false
    t.string "supervising_engineer_name", null: false
    t.integer "supervising_engineer_check", null: false
    t.string "supervising_engineer_assistant_name"
    t.string "professional_engineer_name"
    t.string "professional_engineer_construction_details"
    t.string "safety_officer_name", null: false
    t.string "safety_officer_position_name", null: false
    t.string "general_safety_manager_name"
    t.string "general_safety_manager_position_name"
    t.string "safety_manager_name"
    t.string "safety_manager_position_name"
    t.string "health_manager_name"
    t.string "health_manager_position_name"
    t.string "health_and_safety_promoter_name"
    t.string "health_and_safety_promoter_position_name"
    t.string "confirm_name", null: false
    t.date "accept_confirm_date"
    t.string "subcontractor_name", null: false
    t.json "content"
    t.index ["business_id"], name: "index_orders_on_business_id"
  end

  create_table "request_order_hierarchies", id: false, charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.integer "ancestor_id", null: false
    t.integer "descendant_id", null: false
    t.integer "generations", null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "request_order_anc_desc_idx", unique: true
    t.index ["descendant_id"], name: "request_order_desc_idx"
  end

  create_table "request_orders", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.integer "status", default: 0
    t.bigint "order_id", null: false
    t.bigint "business_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "parent_id"
    t.string "uuid", null: false
    t.string "construction_name"
    t.string "construction_details"
    t.date "start_date"
    t.date "end_date"
    t.date "contract_date"
    t.string "supervisor_name"
    t.string "supervisor_apply"
    t.string "professional_engineer_name"
    t.string "professional_engineer_details"
    t.integer "professional_construction"
    t.string "construction_manager_name"
    t.string "construction_manager_position_name"
    t.string "site_agent_name"
    t.string "site_agent_apply"
    t.string "lead_engineer_name"
    t.integer "lead_engineer_check"
    t.string "work_chief_name"
    t.string "work_conductor_name"
    t.string "safety_officer_name"
    t.string "safety_manager_name"
    t.string "safety_promoter_name"
    t.string "foreman_name"
    t.string "registered_core_engineer_name"
    t.json "content"
    t.index ["business_id"], name: "index_request_orders_on_business_id"
    t.index ["order_id"], name: "index_request_orders_on_order_id"
  end

  create_table "skill_trainings", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "short_name", null: false
    t.json "details"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "solvents", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "name", null: false
    t.string "maker", null: false
    t.string "classification", null: false
    t.string "ingredients", null: false
    t.bigint "business_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_id"], name: "index_solvents_on_business_id"
  end

  create_table "special_educations", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "special_med_exams", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "special_vehicles", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "name", null: false
    t.string "maker", null: false
    t.string "standards_performance", null: false
    t.date "year_manufactured", null: false
    t.string "control_number", null: false
    t.date "check_exp_date_year", null: false
    t.date "check_exp_date_month", null: false
    t.date "check_exp_date_specific", null: false
    t.date "check_exp_date_machine", null: false
    t.date "check_exp_date_car", null: false
    t.integer "personal_insurance"
    t.integer "objective_insurance"
    t.integer "passenger_insurance"
    t.integer "other_insurance"
    t.date "exp_date_insurance"
    t.bigint "business_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["business_id"], name: "index_special_vehicles_on_business_id"
  end

  create_table "tags", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.integer "age"
    t.integer "gender"
    t.integer "role", default: 1
    t.bigint "admin_user_id"
    t.index ["admin_user_id"], name: "index_users_on_admin_user_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "worker_exams", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "worker_medical_id", null: false
    t.bigint "special_med_exam_id", null: false
    t.date "got_on", null: false
    t.json "images"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["special_med_exam_id"], name: "index_worker_exams_on_special_med_exam_id"
    t.index ["worker_medical_id", "special_med_exam_id"], name: "index_worker_exams_on_worker_medical_id_and_special_med_exam_id", unique: true
    t.index ["worker_medical_id"], name: "index_worker_exams_on_worker_medical_id"
  end

  create_table "worker_insurances", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.integer "health_insurance_type", null: false
    t.string "health_insurance_name"
    t.integer "pension_insurance_type", null: false
    t.integer "employment_insurance_type", null: false
    t.string "employment_insurance_number"
    t.integer "severance_pay_mutual_aid_type", null: false
    t.string "severance_pay_mutual_aid_name"
    t.bigint "worker_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["worker_id"], name: "index_worker_insurances_on_worker_id"
  end

  create_table "worker_licenses", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.date "got_on", null: false
    t.json "images"
    t.bigint "worker_id", null: false
    t.bigint "license_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["license_id"], name: "index_worker_licenses_on_license_id"
    t.index ["worker_id", "license_id"], name: "index_worker_licenses_on_worker_id_and_license_id", unique: true
    t.index ["worker_id"], name: "index_worker_licenses_on_worker_id"
  end

  create_table "worker_medicals", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.bigint "worker_id", null: false
    t.date "med_exam_on", null: false
    t.integer "max_blood_pressure", null: false
    t.integer "min_blood_pressure", null: false
    t.date "special_med_exam_on"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["worker_id"], name: "index_worker_medicals_on_worker_id"
  end

  create_table "worker_skill_trainings", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.date "got_on", null: false
    t.json "images"
    t.bigint "worker_id", null: false
    t.bigint "skill_training_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["skill_training_id"], name: "index_worker_skill_trainings_on_skill_training_id"
    t.index ["worker_id", "skill_training_id"], name: "index_worker_skill_trainings_on_worker_id_and_skill_training_id", unique: true
    t.index ["worker_id"], name: "index_worker_skill_trainings_on_worker_id"
  end

  create_table "worker_special_educations", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.date "got_on", null: false
    t.json "images"
    t.bigint "worker_id", null: false
    t.bigint "special_education_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["special_education_id"], name: "index_worker_special_educations_on_special_education_id"
    t.index ["worker_id", "special_education_id"], name: "worker_special_education_index", unique: true
    t.index ["worker_id"], name: "index_worker_special_educations_on_worker_id"
  end

  create_table "workers", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "name_kana", null: false
    t.string "country", null: false
    t.string "my_address", null: false
    t.string "my_phone_number", null: false
    t.string "family_address", null: false
    t.string "family_phone_number", null: false
    t.date "birth_day_on", null: false
    t.integer "abo_blood_type", default: 0, null: false
    t.integer "rh_blood_type", default: 0, null: false
    t.integer "job_type", default: 0, null: false
    t.date "hiring_on", null: false
    t.integer "experience_term_before_hiring", null: false
    t.integer "blank_term", null: false
    t.string "carrier_up_id"
    t.json "images"
    t.bigint "business_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "uuid", null: false
    t.string "job_title", null: false
    t.index ["business_id"], name: "index_workers_on_business_id"
  end

  add_foreign_key "articles", "users"
  add_foreign_key "business_industries", "businesses"
  add_foreign_key "business_industries", "industries"
  add_foreign_key "business_occupations", "businesses"
  add_foreign_key "business_occupations", "occupations"
  add_foreign_key "businesses", "users"
  add_foreign_key "car_voluntary_insurances", "car_insurance_companies", column: "company_voluntary_id"
  add_foreign_key "car_voluntary_insurances", "cars", column: "car_voluntary_id"
  add_foreign_key "cars", "businesses"
  add_foreign_key "cars", "car_insurance_companies"
  add_foreign_key "documents", "businesses"
  add_foreign_key "documents", "request_orders"
  add_foreign_key "field_fire_fire_managements", "field_fires"
  add_foreign_key "field_fire_fire_managements", "fire_managements"
  add_foreign_key "field_fire_fire_types", "field_fires"
  add_foreign_key "field_fire_fire_types", "fire_types"
  add_foreign_key "field_fire_fire_use_targets", "field_fires"
  add_foreign_key "field_fire_fire_use_targets", "fire_use_targets"
  add_foreign_key "machine_tags", "machines"
  add_foreign_key "machine_tags", "tags"
  add_foreign_key "machines", "businesses"
  add_foreign_key "news_users", "news"
  add_foreign_key "news_users", "users"
  add_foreign_key "orders", "businesses"
  add_foreign_key "request_orders", "businesses"
  add_foreign_key "request_orders", "orders"
  add_foreign_key "solvents", "businesses"
  add_foreign_key "special_vehicles", "businesses"
  add_foreign_key "worker_exams", "special_med_exams"
  add_foreign_key "worker_exams", "worker_medicals"
  add_foreign_key "worker_insurances", "workers"
  add_foreign_key "worker_licenses", "licenses"
  add_foreign_key "worker_licenses", "workers"
  add_foreign_key "worker_medicals", "workers"
  add_foreign_key "worker_skill_trainings", "skill_trainings"
  add_foreign_key "worker_skill_trainings", "workers"
  add_foreign_key "worker_special_educations", "special_educations"
  add_foreign_key "worker_special_educations", "workers"
  add_foreign_key "workers", "businesses"
end

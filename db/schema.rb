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

ActiveRecord::Schema.define(version: 2022_05_17_013339) do

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

  create_table "licenses", charset: "utf8mb4", collation: "utf8mb4_general_ci", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.integer "license_type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
    t.index ["business_id"], name: "index_workers_on_business_id"
  end

  add_foreign_key "business_occupations", "businesses"
  add_foreign_key "business_occupations", "occupations"
  add_foreign_key "businesses", "users"
  add_foreign_key "car_voluntary_insurances", "car_insurance_companies", column: "company_voluntary_id"
  add_foreign_key "car_voluntary_insurances", "cars", column: "car_voluntary_id"
  add_foreign_key "cars", "businesses"
  add_foreign_key "cars", "car_insurance_companies"
  add_foreign_key "documents", "businesses"
  add_foreign_key "documents", "request_orders"
  add_foreign_key "news_users", "news"
  add_foreign_key "news_users", "users"
  add_foreign_key "orders", "businesses"
  add_foreign_key "request_orders", "businesses"
  add_foreign_key "request_orders", "orders"
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

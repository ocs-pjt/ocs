# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140305091725) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "additional_informations", force: true do |t|
    t.string   "operating_system"
    t.string   "collection_point"
    t.string   "optional"
    t.string   "description"
    t.datetime "deferred_date"
    t.string   "postman_name"
    t.string   "postman_version"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "collector_versions", force: true do |t|
    t.string   "version"
    t.integer  "collector_id"
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "collector_versions", ["collector_id", "version"], name: "index_collector_versions_on_collector_id_and_version", unique: true, using: :btree

  create_table "collectors", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "in_progress_tasks", force: true do |t|
    t.integer  "user_id"
    t.string   "job_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permutations", force: true do |t|
    t.text     "data"
    t.integer  "use_case_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "already_handled",           default: false
    t.integer  "additional_information_id"
  end

  create_table "program_versions", force: true do |t|
    t.string   "version"
    t.integer  "program_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "programs", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regular_expressions", force: true do |t|
    t.text     "data"
    t.integer  "use_case_id"
    t.boolean  "already_handled",           default: false
    t.integer  "additional_information_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "statistics", force: true do |t|
    t.integer  "user_id"
    t.hstore   "stats"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags_use_cases", force: true do |t|
    t.integer "tag_id"
    t.integer "use_case_id"
  end

  add_index "tags_use_cases", ["use_case_id", "tag_id"], name: "index_tags_use_cases_on_use_case_id_and_tag_id", using: :btree
  add_index "tags_use_cases", ["use_case_id"], name: "index_tags_use_cases_on_use_case_id", using: :btree

  create_table "tags_users", force: true do |t|
    t.integer "tag_id"
    t.integer "user_id"
  end

  add_index "tags_users", ["user_id", "tag_id"], name: "index_tags_users_on_user_id_and_tag_id", using: :btree
  add_index "tags_users", ["user_id"], name: "index_tags_users_on_user_id", using: :btree

  create_table "tasks", force: true do |t|
    t.integer  "user_id"
    t.string   "file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "traces", force: true do |t|
    t.text     "data"
    t.integer  "use_case_id"
    t.boolean  "already_handled",           default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "additional_information_id"
  end

  create_table "use_cases", force: true do |t|
    t.string   "key"
    t.integer  "user_id"
    t.integer  "collector_version_id"
    t.integer  "program_id"
    t.integer  "program_version_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,     null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "provider"
    t.string   "uid"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "postal_address"
    t.string   "country_code"
    t.string   "state_code"
    t.string   "state"
    t.string   "jvectormap_state_code"
    t.boolean  "is_active",              default: false
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end

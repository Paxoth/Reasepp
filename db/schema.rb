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

ActiveRecord::Schema.define(version: 20171221165508) do

  create_table "areas", force: :cascade do |t|
    t.string "description", limit: 255
    t.string "name",        limit: 255
    t.text   "discipline",  limit: 65535
  end

  create_table "bulletins", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.date     "start_date"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "receiver",    limit: 4
    t.integer  "user_id",     limit: 4,     default: 1
  end

  create_table "comments", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",    limit: 4
    t.text     "body",       limit: 65535
    t.integer  "post_id",    limit: 4
    t.string   "post_type",  limit: 255
  end

  add_index "comments", ["post_type", "post_id"], name: "index_comments_on_post_type_and_post_id", using: :btree

  create_table "contacts", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.text     "body",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "events", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.string   "title",       limit: 255
    t.text     "description", limit: 65535
    t.text     "address",     limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer  "status",      limit: 4,     default: 1
  end

  create_table "experiences", force: :cascade do |t|
    t.text     "description",         limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title",               limit: 255
    t.integer  "institution_id",      limit: 4
    t.text     "faculty",             limit: 65535
    t.text     "department",          limit: 65535
    t.text     "course_name",         limit: 65535
    t.text     "course_type",         limit: 65535
    t.text     "course_type_other",   limit: 65535
    t.integer  "period",              limit: 4
    t.text     "professor_phone",     limit: 65535
    t.text     "learning_objectives", limit: 65535
    t.text     "service_objectives",  limit: 65535
    t.text     "frequency",           limit: 65535
    t.integer  "participants",        limit: 4
    t.text     "students_level",      limit: 65535
    t.text     "community_partner",   limit: 65535
    t.text     "organization_type",   limit: 65535
    t.text     "results",             limit: 65535
    t.text     "tools",               limit: 65535
    t.text     "reflection_moments",  limit: 65535
    t.integer  "area_id",             limit: 4
    t.integer  "professor_degree",    limit: 4
    t.integer  "service_id",          limit: 4
    t.date     "start_time"
    t.date     "end_time"
    t.integer  "professor_id",        limit: 4
    t.integer  "partner_id",          limit: 4
    t.integer  "weekly_hours",        limit: 4,     default: 0
    t.integer  "benefited",           limit: 4,     default: 0
    t.text     "partner_name",        limit: 65535
    t.text     "region",              limit: 65535
    t.text     "comuna",              limit: 65535
    t.integer  "broker_id",           limit: 4
  end

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "provider",   limit: 255
    t.string   "uid",        limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "identities", ["user_id"], name: "index_identities_on_user_id", using: :btree

  create_table "institutions", force: :cascade do |t|
    t.text     "description",       limit: 65535
    t.string   "name",              limit: 255
    t.text     "web",               limit: 65535
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "logo_file_name",    limit: 255
    t.string   "logo_content_type", limit: 255
    t.integer  "logo_file_size",    limit: 4
    t.datetime "logo_updated_at"
    t.integer  "manager_id",        limit: 4
    t.text     "twitter",           limit: 65535
    t.text     "facebook",          limit: 65535
    t.text     "youtube",           limit: 65535
    t.text     "linkedin",          limit: 65535
    t.text     "instagram",         limit: 65535
  end

  create_table "interest_links", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.string   "url",         limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.integer  "user_id",     limit: 4,     default: 1
  end

  create_table "offerings", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.string   "title",          limit: 255
    t.text     "description",    limit: 65535
    t.date     "start_time"
    t.date     "end_time"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.text     "resume",         limit: 65535
    t.integer  "status",         limit: 4,     default: 1
    t.integer  "area_id",        limit: 4
    t.text     "location",       limit: 65535
    t.integer  "institution_id", limit: 4
    t.integer  "broker_id",      limit: 4
  end

  add_index "offerings", ["user_id"], name: "index_offerings_on_user_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.text     "title",      limit: 65535
    t.text     "answer",     limit: 65535
    t.integer  "reader",     limit: 4
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "user_id",    limit: 4,     default: 1
  end

  create_table "requests", force: :cascade do |t|
    t.integer  "user_id",        limit: 4
    t.integer  "area_id",        limit: 4
    t.string   "title",          limit: 255
    t.text     "description",    limit: 65535
    t.date     "start_time"
    t.date     "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "resume",         limit: 65535
    t.integer  "status",         limit: 4,     default: 1
    t.text     "location",       limit: 65535
    t.integer  "institution_id", limit: 4
    t.integer  "broker_id",      limit: 4
  end

  create_table "resources", force: :cascade do |t|
    t.string   "name",                 limit: 255
    t.date     "date"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "archive_file_name",    limit: 255
    t.string   "archive_content_type", limit: 255
    t.integer  "archive_file_size",    limit: 4
    t.datetime "archive_updated_at"
    t.integer  "category",             limit: 4,     default: 1
    t.text     "description",          limit: 65535
    t.integer  "user_id",              limit: 4,     default: 1
  end

  create_table "sections", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.string   "module",     limit: 255
    t.text     "body",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "priority",   limit: 4,     default: 1
    t.integer  "user_id",    limit: 4,     default: 1
  end

  create_table "services", force: :cascade do |t|
    t.integer  "publication_id",      limit: 4
    t.string   "publication_type",    limit: 255
    t.integer  "creator_id",          limit: 4
    t.integer  "acceptor_id",         limit: 4
    t.integer  "area_id",             limit: 4
    t.integer  "institution_id",      limit: 4
    t.text     "title",               limit: 65535
    t.integer  "status",              limit: 4
    t.text     "message",             limit: 65535
    t.text     "description",         limit: 65535
    t.text     "resume",              limit: 65535
    t.date     "start_time"
    t.date     "end_time"
    t.text     "learning_objectives", limit: 65535
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.text     "service_objectives",  limit: 65535
    t.integer  "broker_id",           limit: 4
  end

  add_index "services", ["publication_type", "publication_id"], name: "index_services_on_publication_type_and_publication_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255,   default: "",    null: false
    t.string   "encrypted_password",     limit: 255,   default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.integer  "institution_id",         limit: 4
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.string   "name",                   limit: 255
    t.integer  "autorization_level",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category",               limit: 4
    t.string   "nickname",               limit: 255
    t.string   "photo_file_name",        limit: 255
    t.string   "photo_content_type",     limit: 255
    t.integer  "photo_file_size",        limit: 4
    t.datetime "photo_updated_at"
    t.text     "description",            limit: 65535
    t.boolean  "is_admin",               limit: 1,     default: false
    t.boolean  "institution_custom",     limit: 1,     default: false
    t.text     "twitter",                limit: 65535
    t.text     "facebook",               limit: 65535
    t.text     "youtube",                limit: 65535
    t.text     "linkedin",               limit: 65535
    t.text     "instagram",              limit: 65535
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "identities", "users"
  add_foreign_key "offerings", "users"
end

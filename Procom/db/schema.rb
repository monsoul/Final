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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130115064709) do

  create_table "applicants", :force => true do |t|
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.string   "username",          :limit => 20, :null => false
    t.string   "email",             :limit => 20, :null => false
    t.string   "mobile",            :limit => 20, :null => false
    t.string   "real_name",         :limit => 20, :null => false
    t.integer  "school_id",                       :null => false
    t.string   "keywords",          :limit => 20
    t.text     "comments"
    t.integer  "acceptance_userid"
    t.string   "committer_status",  :limit => 10, :null => false
    t.string   "status",            :limit => 10
  end

  create_table "article_tags", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "article_id", :null => false
    t.integer  "tag_id",     :null => false
  end

  create_table "articles", :force => true do |t|
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "title",        :limit => 30, :null => false
    t.text     "brief"
    t.text     "content"
    t.string   "article_type", :limit => 10, :null => false
    t.integer  "qa_id"
    t.string   "pic"
    t.integer  "user_id",                    :null => false
  end

  create_table "dictionaries", :force => true do |t|
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.string   "value_id",         :limit => 10, :null => false
    t.string   "value_content",    :limit => 30, :null => false
    t.string   "value_content_cn", :limit => 30, :null => false
    t.string   "value_type",       :limit => 30, :null => false
  end

  create_table "qas", :force => true do |t|
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "ask_user_id",                      :null => false
    t.integer  "asked_user_id",                    :null => false
    t.string   "question_title",     :limit => 20, :null => false
    t.text     "content",                          :null => false
    t.integer  "origin_question_id"
  end

  create_table "schools", :force => true do |t|
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
    t.string   "school_name", :limit => 30, :null => false
    t.string   "province",    :limit => 20
    t.string   "city",        :limit => 20, :null => false
    t.string   "pic"
    t.string   "status",      :limit => 10, :null => false
  end

  create_table "tags", :force => true do |t|
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.string   "name",       :limit => 30, :null => false
  end

  create_table "users", :force => true do |t|
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.string   "username",     :limit => 20, :null => false
    t.string   "password",     :limit => 32, :null => false
    t.string   "email",                      :null => false
    t.string   "mobile",       :limit => 15
    t.string   "real_name",    :limit => 20, :null => false
    t.string   "pic"
    t.string   "full_pic"
    t.integer  "applicant_id"
    t.string   "role",         :limit => 20
    t.float    "score"
    t.string   "status",       :limit => 10, :null => false
  end

end

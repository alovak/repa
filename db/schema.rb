# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090610123236) do

  create_table "changes", :force => true do |t|
    t.boolean  "assignee_changed"
    t.integer  "assignee_was"
    t.integer  "assignee_is"
    t.boolean  "state_changed"
    t.integer  "state_was"
    t.integer  "state_is"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups_users", :id => false, :force => true do |t|
    t.integer "group_id"
    t.integer "user_id"
  end

  add_index "groups_users", ["group_id", "user_id"], :name => "index_groups_users_on_group_id_and_user_id"
  add_index "groups_users", ["user_id"], :name => "index_groups_users_on_user_id"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "tasks", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "group_id"
    t.integer  "periodicity"
    t.date     "start_on"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "create_work_on"
  end

  create_table "tickets", :force => true do |t|
    t.string   "title"
    t.string   "state"
    t.text     "description"
    t.text     "implementation"
    t.text     "affected_before"
    t.text     "affected_during"
    t.text     "affected_after"
    t.text     "implementation_risks"
    t.text     "rollback_procedure"
    t.text     "request_alternatives"
    t.integer  "onwer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "assignee_id"
  end

  create_table "users", :force => true do |t|
    t.string   "name",            :limit => 50
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "hashed_password"
    t.string   "salt"
    t.boolean  "is_admin",                      :default => false
  end

  create_table "works", :force => true do |t|
    t.integer  "task_id"
    t.integer  "owner_id"
    t.integer  "group_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

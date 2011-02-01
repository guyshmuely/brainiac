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

ActiveRecord::Schema.define(:version => 20110102151406) do

  create_table "cards", :force => true do |t|
    t.integer  "course_id"
    t.text     "question"
    t.text     "solution"
    t.string   "question_direction"
    t.string   "solution_direction"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", :force => true do |t|
    t.string   "display_name"
    t.string   "title"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.string   "icon_file_name"
    t.string   "icon_content_type"
    t.integer  "image_file_size"
    t.integer  "icon_file_size"
    t.integer  "price_in_cents"
    t.datetime "image_updated_at"
    t.datetime "icon_updated_at"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

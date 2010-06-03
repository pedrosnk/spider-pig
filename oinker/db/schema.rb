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

ActiveRecord::Schema.define(:version => 20100603170125) do

  create_table "tweeters", :force => true do |t|
    t.datetime "created_at"
    t.integer  "friends_count"
    t.string   "profile_image_url"
    t.integer  "followers_count"
    t.string   "screen_name"
    t.string   "location"
    t.boolean  "geo_enabled"
    t.string   "time_zone"
    t.boolean  "protected"
    t.string   "description"
    t.string   "profile_background_image_url"
    t.string   "url"
    t.integer  "statuses_count"
    t.datetime "updated_at"
  end

end
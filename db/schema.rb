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

ActiveRecord::Schema.define(:version => 20110610085806) do

  create_table "caps", :force => true do |t|
    t.integer  "num"
    t.string   "spa",        :null => false
    t.string   "eng"
    t.string   "por"
    t.string   "rus"
    t.string   "man"
    t.string   "fre"
    t.string   "start"
    t.string   "stop"
    t.string   "url"
    t.string   "lang"
    t.string   "source"
    t.string   "source2"
    t.integer  "wcount"
    t.integer  "ccount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "hide"
  end

  add_index "caps", ["eng"], :name => "index_caps_on_eng"
  add_index "caps", ["fre"], :name => "index_caps_on_fre"
  add_index "caps", ["hide"], :name => "index_caps_on_hide"
  add_index "caps", ["lang"], :name => "index_caps_on_lang"
  add_index "caps", ["man"], :name => "index_caps_on_man"
  add_index "caps", ["num"], :name => "index_caps_on_num"
  add_index "caps", ["por"], :name => "index_caps_on_por"
  add_index "caps", ["rus"], :name => "index_caps_on_rus"
  add_index "caps", ["source"], :name => "index_caps_on_source"
  add_index "caps", ["spa"], :name => "index_caps_on_spa"
  add_index "caps", ["start"], :name => "index_caps_on_start"
  add_index "caps", ["stop"], :name => "index_caps_on_stop"
  add_index "caps", ["url"], :name => "index_caps_on_url"
  add_index "caps", ["wcount"], :name => "index_caps_on_wcount"

  create_table "roots", :force => true do |t|
    t.string   "verb"
    t.string   "trans"
    t.string   "kind"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "searches", :force => true do |t|
    t.string   "search"
    t.integer  "user_id"
    t.string   "lang"
    t.string   "category"
    t.integer  "page"
    t.boolean  "option"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "searches", ["category"], :name => "index_searches_on_category"
  add_index "searches", ["lang"], :name => "index_searches_on_lang"
  add_index "searches", ["option"], :name => "index_searches_on_option"
  add_index "searches", ["page"], :name => "index_searches_on_page"
  add_index "searches", ["user_id"], :name => "index_searches_on_user_id"

  create_table "tracks", :force => true do |t|
    t.string   "ip"
    t.string   "search"
    t.string   "lang"
    t.string   "page"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tracks", ["ip"], :name => "index_tracks_on_ip"
  add_index "tracks", ["lang"], :name => "index_tracks_on_lang"

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password"
    t.string   "encrypted_password"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "extra"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "salt"
  end

  create_table "verbs", :force => true do |t|
    t.string   "verb"
    t.string   "conj"
    t.string   "mood"
    t.string   "tense"
    t.string   "tense_type"
    t.string   "pro"
    t.string   "pre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "verbs", ["conj"], :name => "index_verbs_on_conj"
  add_index "verbs", ["mood"], :name => "index_verbs_on_mood"
  add_index "verbs", ["pre"], :name => "index_verbs_on_pre"
  add_index "verbs", ["tense"], :name => "index_verbs_on_tense"
  add_index "verbs", ["verb"], :name => "index_verbs_on_verb"

  create_table "words", :force => true do |t|
    t.string   "word"
    t.string   "info"
    t.string   "extra"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "words", ["word"], :name => "index_words_on_word"

end

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

ActiveRecord::Schema[7.1].define(version: 2023_11_25_045036) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "personalizations", force: :cascade do |t|
    t.string "name"
    t.json "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "search_fields", force: :cascade do |t|
    t.string "name"
    t.string "value"
    t.float "factor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "boost_by_recency_scale"
    t.float "boost_by_recency_decay"
    t.integer "kind"
    t.boolean "active"
  end

  create_table "searchjoy_conversions", force: :cascade do |t|
    t.bigint "search_id"
    t.string "convertable_type"
    t.bigint "convertable_id"
    t.datetime "created_at"
    t.index ["convertable_type", "convertable_id"], name: "index_searchjoy_conversions_on_convertable"
    t.index ["search_id"], name: "index_searchjoy_conversions_on_search_id"
  end

  create_table "searchjoy_searches", force: :cascade do |t|
    t.bigint "user_id"
    t.string "search_type"
    t.string "query"
    t.string "normalized_query"
    t.integer "results_count"
    t.datetime "created_at"
    t.datetime "converted_at"
    t.index ["created_at"], name: "index_searchjoy_searches_on_created_at"
    t.index ["search_type", "created_at"], name: "index_searchjoy_searches_on_search_type_and_created_at"
    t.index ["search_type", "normalized_query", "created_at"], name: "index_searchjoy_searches_on_search_type_query"
    t.index ["user_id"], name: "index_searchjoy_searches_on_user_id"
  end

  create_table "submisions", force: :cascade do |t|
    t.string "score"
    t.text "submission"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "videos", force: :cascade do |t|
    t.string "video_id"
    t.string "video_title"
    t.string "channel_title"
    t.datetime "v_channel_reg_datetime_x"
    t.string "v_channel_type_x"
    t.string "v_category_x"
    t.datetime "v_pub_datetime_x"
    t.date "report_date"
    t.datetime "v_channel_reg_datetime_y"
    t.string "v_channel_type_y"
    t.string "v_category_y"
    t.datetime "v_pub_datetime_y"
    t.float "total_comments"
    t.float "v_year_views"
    t.float "v_month_views"
    t.float "v_week_views"
    t.float "v_day_views"
    t.float "v_likes"
    t.float "v_dislikes"
    t.float "v_duration"
    t.float "v_cr_click_like_7_days"
    t.float "v_cr_click_dislike_7_days"
    t.float "v_cr_click_vtop_7_days"
    t.float "v_cr_click_long_view_7_days"
    t.float "v_cr_click_comment_7_days"
    t.float "v_cr_click_like_30_days"
    t.float "v_cr_click_dislike_30_days"
    t.float "v_cr_click_vtop_30_days"
    t.float "v_cr_click_long_view_30_days"
    t.float "v_cr_click_comment_30_days"
    t.float "v_cr_click_like_1_days"
    t.float "v_cr_click_dislike_1_days"
    t.float "v_cr_click_vtop_1_days"
    t.float "v_cr_click_long_view_1_days"
    t.float "v_cr_click_comment_1_days"
  end

end

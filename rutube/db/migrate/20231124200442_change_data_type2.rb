class ChangeDataType2 < ActiveRecord::Migration[7.1]
  def change
    drop_table :videos
    create_table :videos do |t|
      t.string :video_id
      t.string :video_title
      t.string :channel_title
      t.datetime :v_channel_reg_datetime_x
      t.string :v_channel_type_x
      t.string :v_category_x
      t.datetime :v_pub_datetime_x
      t.date :report_date
      t.datetime :v_channel_reg_datetime_y
      t.string :v_channel_type_y
      t.string :v_category_y
      t.datetime :v_pub_datetime_y
      t.float :total_comments
      t.float :v_year_views
      t.float :v_month_views
      t.float :v_week_views
      t.float :v_day_views
      t.float :v_likes
      t.float :v_dislikes
      t.float :v_duration
      t.float :v_cr_click_like_7_days
      t.float :v_cr_click_dislike_7_days
      t.float :v_cr_click_vtop_7_days
      t.float :v_cr_click_long_view_7_days
      t.float :v_cr_click_comment_7_days
      t.float :v_cr_click_like_30_days
      t.float :v_cr_click_dislike_30_days
      t.float :v_cr_click_vtop_30_days
      t.float :v_cr_click_long_view_30_days
      t.float :v_cr_click_comment_30_days
      t.float :v_cr_click_like_1_days
      t.float :v_cr_click_dislike_1_days
      t.float :v_cr_click_vtop_1_days
      t.float :v_cr_click_long_view_1_days
      t.float :v_cr_click_comment_1_days
    end
  end
end

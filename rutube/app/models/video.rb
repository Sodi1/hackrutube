class Video < ApplicationRecord

  searchkick language: "russian", suggest: [:video_title], callbacks: :queue, word_start: [:video_title, :channel_title]
  # def search_data
  #   {
  #     video_title: ,
  #     channel_title:,
  #     v_category_x:,
  #     v_pub_datetime_x:,
  #     v_duration:,
  #     v_dislikes:,
  #     v_likes:,
  #     total_comments:,
  #   }
  # end
end

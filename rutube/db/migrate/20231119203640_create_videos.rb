class CreateVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :videos do |t|
      t.string :title
      t.string :description
      t.string :keywords
      t.datetime :published_at

      t.timestamps
    end
  end
end

class ChangeDataType < ActiveRecord::Migration[7.1]
  def change
    change_column :videos, :total_comments, :float

  end
end

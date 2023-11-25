class AddFieldsToVideo < ActiveRecord::Migration[7.1]
  def change
    remove_column :videos, :keywords
    add_column :videos, :keywords, :string, array: true
    add_column :videos, :likes, :integer
    add_column :videos, :category, :string
    add_column :videos, :dislikes, :integer
    add_column :videos, :views, :integer
  end
end

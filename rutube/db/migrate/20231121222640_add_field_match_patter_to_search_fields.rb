class AddFieldMatchPatterToSearchFields < ActiveRecord::Migration[7.1]
  def change
    add_column :search_fields, :match_pattern, :integer
  end
end

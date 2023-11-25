class RemoveMatchPattern < ActiveRecord::Migration[7.1]
  def change
    remove_column :search_fields, :match_pattern
  end
end

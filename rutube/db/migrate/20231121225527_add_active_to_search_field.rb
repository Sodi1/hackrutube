class AddActiveToSearchField < ActiveRecord::Migration[7.1]
  def change
    add_column :search_fields, :active, :boolean
  end
end

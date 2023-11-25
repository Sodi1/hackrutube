class AddKindToSearchFields < ActiveRecord::Migration[7.1]
  def change
    add_column :search_fields, :kind, :integer
  end
end

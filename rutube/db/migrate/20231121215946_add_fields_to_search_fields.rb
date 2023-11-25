class AddFieldsToSearchFields < ActiveRecord::Migration[7.1]
  def change
    add_column :search_fields, :boost_by_recency_scale, :string
    add_column :search_fields, :boost_by_recency_decay, :float
  end
end

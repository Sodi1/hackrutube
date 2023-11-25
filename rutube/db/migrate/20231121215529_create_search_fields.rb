class CreateSearchFields < ActiveRecord::Migration[7.1]
  def change
    create_table :search_fields do |t|
      t.string :name
      t.string :value
      t.float :factor

      t.timestamps
    end
  end
end

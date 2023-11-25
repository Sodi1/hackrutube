class CreatePersonalizations < ActiveRecord::Migration[7.1]
  def change
    create_table :personalizations do |t|
      t.string :name
      t.json :value
      t.timestamps
    end
  end
end

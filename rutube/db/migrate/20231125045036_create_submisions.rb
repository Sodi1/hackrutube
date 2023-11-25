class CreateSubmisions < ActiveRecord::Migration[7.1]
  def change
    create_table :submisions do |t|
      t.string :score
      t.text :submission

      t.timestamps
    end
  end
end

class CreateHottopics < ActiveRecord::Migration
  def change
    create_table :hottopics do |t|
      t.string :Search_word
      t.date :Search_date

      t.timestamps null: false
    end
  end
end

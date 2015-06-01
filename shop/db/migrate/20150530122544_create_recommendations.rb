class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.string :User_id
      t.string :Sex
      t.integer :Age
      t.string :Category
      t.integer :Notice_id

      t.timestamps null: false
    end
  end
end

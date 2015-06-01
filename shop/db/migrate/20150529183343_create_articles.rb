class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :User_id
      t.string :Seller_id
      t.string :Title
      t.text :Contents
      t.text :Reply
      t.integer :Notice_id
      t.string :Category

      t.timestamps null: false
    end
  end
end

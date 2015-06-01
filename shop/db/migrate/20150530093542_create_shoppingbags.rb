class CreateShoppingbags < ActiveRecord::Migration
  def change
    create_table :shoppingbags do |t|
      t.integer :Notice_id
      t.string :Notice_title
      t.integer :Product_id
      t.string :Product_name
      t.integer :Product_num
      t.integer :Product_price
      t.integer :Deliver_charge
      t.string :User_id

      t.timestamps null: false
    end
  end
end

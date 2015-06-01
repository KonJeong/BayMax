class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string :Seller_id
      t.string :Buyer_id
      t.string :Receiptor_name
      t.integer :Total_price
      t.integer :Product_id
      t.integer :Product_num
      t.string :Message
      t.string :Phone
      t.string :Address
      t.integer :Receipt
      t.integer :Return
      t.string :picture
      t.integer :Notice_id
      t.string :Notice_name

      t.timestamps null: false
    end
  end
end

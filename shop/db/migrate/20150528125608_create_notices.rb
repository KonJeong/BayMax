class CreateNotices < ActiveRecord::Migration
  def change
    create_table :notices do |t|
      t.string :Seller_id
      t.string :Title
      t.integer :Price
      t.string :Sex
      t.integer :Age
      t.string :Category
      t.integer :Sell_count
      t.integer :Deliver_charge
      t.string :picture

      t.timestamps null: false
    end
  end
end

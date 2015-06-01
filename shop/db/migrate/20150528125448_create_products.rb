class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :Name
      t.integer :Notice_id
      t.integer :Stock
      t.integer :Price
      t.string :picture
      t.string :Show_picture

      t.timestamps null: false
    end
  end
end

class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
		t.string :User_id
		t.string :Password
		t.string :Name
		t.string :Sex
		t.string :Phone
		t.string :Address
		t.string :Email
		t.date :Birth
		t.integer :Class
		t.integer :Mileage
      t.timestamps null: false
    end
  end
end

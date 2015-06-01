# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150530122544) do

  create_table "articles", force: :cascade do |t|
    t.string   "User_id"
    t.string   "Seller_id"
    t.string   "Title"
    t.text     "Contents"
    t.text     "Reply"
    t.integer  "Notice_id"
    t.string   "Category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deals", force: :cascade do |t|
    t.string   "Seller_id"
    t.string   "Buyer_id"
    t.string   "Receiptor_name"
    t.integer  "Total_price"
    t.integer  "Product_id"
    t.integer  "Product_num"
    t.string   "Message"
    t.string   "Phone"
    t.string   "Address"
    t.integer  "Receipt"
    t.integer  "Return"
    t.string   "picture"
    t.integer  "Notice_id"
    t.string   "Notice_name"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "hottopics", force: :cascade do |t|
    t.string   "Search_word"
    t.date     "Search_date"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "members", force: :cascade do |t|
    t.string   "User_id"
    t.string   "Password"
    t.string   "Name"
    t.string   "Sex"
    t.string   "Phone"
    t.string   "Address"
    t.string   "Email"
    t.date     "Birth"
    t.integer  "Class"
    t.integer  "Mileage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notices", force: :cascade do |t|
    t.string   "Seller_id"
    t.string   "Title"
    t.integer  "Price"
    t.string   "Sex"
    t.integer  "Age"
    t.string   "Category"
    t.integer  "Sell_count"
    t.integer  "Deliver_charge"
    t.string   "picture"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "products", force: :cascade do |t|
    t.string   "Name"
    t.integer  "Notice_id"
    t.integer  "Stock"
    t.integer  "Price"
    t.string   "picture"
    t.string   "Show_picture"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "recommendations", force: :cascade do |t|
    t.string   "User_id"
    t.string   "Sex"
    t.integer  "Age"
    t.string   "Category"
    t.integer  "Notice_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shoppingbags", force: :cascade do |t|
    t.integer  "Notice_id"
    t.string   "Notice_title"
    t.integer  "Product_id"
    t.string   "Product_name"
    t.integer  "Product_num"
    t.integer  "Product_price"
    t.integer  "Deliver_charge"
    t.string   "User_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

end

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_11_21_081352) do

  create_table "order_details", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "soccer_field_id", null: false
    t.bigint "current_price"
    t.integer "booking_used", null: false
    t.datetime "time_started"
    t.datetime "time_finished"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_order_details_on_order_id"
    t.index ["soccer_field_id"], name: "index_order_details_on_soccer_field_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "quantity"
    t.integer "status"
    t.bigint "total_cost"
    t.integer "is_payment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "soccer_fields", force: :cascade do |t|
    t.string "field_name"
    t.integer "type_field"
    t.bigint "price"
    t.integer "status", default: 0
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "soccer_rates", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "soccer_field_id", null: false
    t.text "comment"
    t.integer "rate"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["soccer_field_id"], name: "index_soccer_rates_on_soccer_field_id"
    t.index ["user_id"], name: "index_soccer_rates_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.string "password_digest"
    t.string "remember_digest"
    t.string "country"
    t.string "address"
    t.integer "role"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_foreign_key "order_details", "orders"
  add_foreign_key "order_details", "soccer_fields"
  add_foreign_key "orders", "users"
  add_foreign_key "soccer_rates", "soccer_fields"
  add_foreign_key "soccer_rates", "users"
end

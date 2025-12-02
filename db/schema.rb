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

ActiveRecord::Schema[7.1].define(version: 2025_12_01_161542) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "stocks", force: :cascade do |t|
    t.integer "quantity"
    t.bigint "user_id", null: false
    t.bigint "drink_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["drink_id"], name: "index_stocks_on_drink_id"
    t.index ["user_id"], name: "index_stocks_on_user_id"
  end

  create_table "drinks", force: :cascade do |t|
    t.string "title"
    t.string "category"
    t.string "region"
    t.integer "year"
    t.text "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "friends", force: :cascade do |t|
    t.bigint "user_main_id"
    t.bigint "user_friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_friend_id"], name: "index_friends_on_user_friend_id"
    t.index ["user_main_id"], name: "index_friends_on_user_main_id"
  end

  create_table "guests", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "meal_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meal_id"], name: "index_guests_on_meal_id"
    t.index ["user_id"], name: "index_guests_on_user_id"
  end

  create_table "meal_drinks", force: :cascade do |t|
    t.bigint "meal_id", null: false
    t.bigint "drink_id", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["drink_id"], name: "index_meal_drinks_on_drink_id"
    t.index ["meal_id"], name: "index_meal_drinks_on_meal_id"
  end

  create_table "meals", force: :cascade do |t|
    t.string "dish_name"
    t.bigint "user_id", null: false
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_meals_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "diet"
    t.string "allergy"
    t.text "like"
    t.text "dislike"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "stocks", "drinks"
  add_foreign_key "stocks", "users"
  add_foreign_key "friends", "users", column: "user_friend_id"
  add_foreign_key "friends", "users", column: "user_main_id"
  add_foreign_key "guests", "meals"
  add_foreign_key "guests", "users"
  add_foreign_key "meal_drinks", "drinks"
  add_foreign_key "meal_drinks", "meals"
  add_foreign_key "meals", "users"
end

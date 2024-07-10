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

ActiveRecord::Schema[7.1].define(version: 2024_07_10_174459) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dividends", force: :cascade do |t|
    t.bigint "stock_id", null: false
    t.date "ex_dividend_date"
    t.date "payment_date"
    t.float "amount"
    t.string "frequency"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["stock_id"], name: "index_dividends_on_stock_id"
  end

  create_table "holdings", force: :cascade do |t|
    t.float "shares"
    t.bigint "portfolio_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "stock_id"
    t.float "average_buy_price"
    t.index ["portfolio_id"], name: "index_holdings_on_portfolio_id"
    t.index ["stock_id"], name: "index_holdings_on_stock_id"
  end

  create_table "portfolios", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_portfolios_on_user_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.string "ticker"
    t.string "name"
    t.float "current_price"
    t.datetime "last_price_update"
    t.datetime "last_dividend_update"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "dividends", "stocks"
  add_foreign_key "holdings", "portfolios"
  add_foreign_key "holdings", "stocks"
  add_foreign_key "portfolios", "users"
end

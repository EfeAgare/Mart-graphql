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

ActiveRecord::Schema.define(version: 2022_09_14_224932) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attribute_values", force: :cascade do |t|
    t.bigint "attribute_id", null: false
    t.string "value", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["attribute_id"], name: "index_attribute_values_on_attribute_id"
  end

  create_table "attributes", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "audits", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.datetime "created_on", null: false
    t.text "message", null: false
    t.integer "code", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_audits_on_order_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.bigint "department_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["department_id"], name: "index_categories_on_department_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "mobile_phone_2"
    t.string "name"
    t.string "mobile_phone"
    t.string "country"
    t.string "postal_code"
    t.string "region"
    t.string "city"
    t.string "address_2"
    t.string "address_1"
    t.string "credit_card"
    t.bigint "shipping_region_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
    t.index ["shipping_region_id"], name: "index_customers_on_shipping_region_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "order_details", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.string "attributes", null: false
    t.integer "quantity", null: false
    t.string "product_name", null: false
    t.decimal "unit_cost", null: false
    t.bigint "product_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_order_details_on_order_id"
    t.index ["product_id"], name: "index_order_details_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.decimal "total_amount", null: false
    t.datetime "created_on", null: false
    t.datetime "shipped_on"
    t.integer "status"
    t.string "comments"
    t.bigint "customer_id", null: false
    t.string "auth_code"
    t.string "reference"
    t.bigint "shipping_id", null: false
    t.bigint "tax_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_orders_on_customer_id"
    t.index ["shipping_id"], name: "index_orders_on_shipping_id"
    t.index ["tax_id"], name: "index_orders_on_tax_id"
  end

  create_table "product_attributes", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "attribute_value_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["attribute_value_id"], name: "index_product_attributes_on_attribute_value_id"
    t.index ["product_id"], name: "index_product_attributes_on_product_id"
  end

  create_table "product_categories", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["category_id"], name: "index_product_categories_on_category_id"
    t.index ["product_id"], name: "index_product_categories_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.decimal "price", null: false
    t.decimal "discounted_price", default: "0.0", null: false
    t.string "image"
    t.string "image_2"
    t.string "thumbnail"
    t.integer "display", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "customer_id"
    t.bigint "product_id", null: false
    t.text "review", null: false
    t.integer "rating", null: false
    t.datetime "created_on", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["customer_id"], name: "index_reviews_on_customer_id"
    t.index ["product_id"], name: "index_reviews_on_product_id"
  end

  create_table "shipping_regions", force: :cascade do |t|
    t.string "region", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "shippings", force: :cascade do |t|
    t.bigint "shipping_region_id", null: false
    t.float "cost", null: false
    t.string "type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["shipping_region_id"], name: "index_shippings_on_shipping_region_id"
  end

  create_table "shopping_carts", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.string "attributes", null: false
    t.integer "quantity", null: false
    t.boolean "buy_now", default: true, null: false
    t.datetime "added_on", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["product_id"], name: "index_shopping_carts_on_product_id"
  end

  create_table "taxes", force: :cascade do |t|
    t.string "type", null: false
    t.float "percentage", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "attribute_values", "attributes"
  add_foreign_key "audits", "orders"
  add_foreign_key "categories", "departments"
  add_foreign_key "order_details", "orders"
  add_foreign_key "order_details", "products"
  add_foreign_key "orders", "customers"
  add_foreign_key "orders", "shippings"
  add_foreign_key "orders", "taxes"
  add_foreign_key "product_attributes", "attribute_values"
  add_foreign_key "product_attributes", "products"
  add_foreign_key "product_categories", "categories"
  add_foreign_key "product_categories", "products"
  add_foreign_key "reviews", "products"
  add_foreign_key "shippings", "shipping_regions"
  add_foreign_key "shopping_carts", "products"
end

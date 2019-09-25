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

ActiveRecord::Schema.define(version: 2019_09_25_161556) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "art_tags", force: :cascade do |t|
    t.bigint "art_id"
    t.bigint "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["art_id"], name: "index_art_tags_on_art_id"
    t.index ["tag_id"], name: "index_art_tags_on_tag_id"
  end

  create_table "artists", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "artist_name"
    t.string "photo"
    t.text "bio"
    t.integer "age"
    t.string "birth_place"
    t.string "instagram"
    t.string "facebook"
    t.string "website"
    t.string "city"
    t.string "country"
    t.float "latitude"
    t.float "longitude"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_artists_on_user_id"
  end

  create_table "arts", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.date "completion_date"
    t.text "inspiration"
    t.boolean "available"
    t.integer "price_cents"
    t.bigint "artist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_arts_on_artist_id"
  end

  create_table "cart_products", force: :cascade do |t|
    t.bigint "shopping_cart_id"
    t.bigint "art_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["art_id"], name: "index_cart_products_on_art_id"
    t.index ["shopping_cart_id"], name: "index_cart_products_on_shopping_cart_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.bigint "art_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["art_id"], name: "index_comments_on_art_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_conversations_on_user_id"
  end

  create_table "followers", force: :cascade do |t|
    t.bigint "artist_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_followers_on_artist_id"
    t.index ["user_id"], name: "index_followers_on_user_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "dialect"
    t.bigint "artist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_languages_on_artist_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "art_id"
    t.bigint "artist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["art_id"], name: "index_likes_on_art_id"
    t.index ["artist_id"], name: "index_likes_on_artist_id"
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "conversation_id"
    t.bigint "user_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "address_line_1"
    t.string "address_line_2"
    t.string "address_city"
    t.integer "address_zipcode"
    t.string "state"
    t.string "country"
    t.integer "phone_number"
    t.jsonb "payment"
    t.integer "amount_cents"
    t.bigint "artist_id"
    t.bigint "shopping_cart_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_orders_on_artist_id"
    t.index ["shopping_cart_id"], name: "index_orders_on_shopping_cart_id"
  end

  create_table "photos", force: :cascade do |t|
    t.bigint "art_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["art_id"], name: "index_photos_on_art_id"
  end

  create_table "reaction_types", force: :cascade do |t|
    t.string "reaction_kind"
    t.bigint "reaction_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reaction_id"], name: "index_reaction_types_on_reaction_id"
  end

  create_table "reactions", force: :cascade do |t|
    t.bigint "art_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["art_id"], name: "index_reactions_on_art_id"
  end

  create_table "shopping_carts", force: :cascade do |t|
    t.integer "total_price_cents"
    t.integer "count"
    t.string "status"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_shopping_carts_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "tagging"
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

  add_foreign_key "art_tags", "arts"
  add_foreign_key "art_tags", "tags"
  add_foreign_key "artists", "users"
  add_foreign_key "arts", "artists"
  add_foreign_key "cart_products", "arts"
  add_foreign_key "cart_products", "shopping_carts"
  add_foreign_key "comments", "arts"
  add_foreign_key "comments", "users"
  add_foreign_key "conversations", "users"
  add_foreign_key "followers", "artists"
  add_foreign_key "followers", "users"
  add_foreign_key "likes", "artists"
  add_foreign_key "likes", "arts"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
  add_foreign_key "orders", "artists"
  add_foreign_key "orders", "shopping_carts"
  add_foreign_key "photos", "arts"
  add_foreign_key "reaction_types", "reactions"
  add_foreign_key "reactions", "arts"
  add_foreign_key "shopping_carts", "users"
end

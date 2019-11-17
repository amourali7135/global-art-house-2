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

ActiveRecord::Schema.define(version: 2019_11_17_134737) do

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

  create_table "artist_tags", force: :cascade do |t|
    t.bigint "artist_id"
    t.bigint "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_artist_tags_on_artist_id"
    t.index ["tag_id"], name: "index_artist_tags_on_tag_id"
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
    t.string "state"
    t.integer "followees_count", default: 0
    t.integer "likees_count", default: 0
    t.bigint "photo_id"
    t.string "form"
    t.index ["photo_id"], name: "index_artists_on_photo_id"
    t.index ["user_id"], name: "index_artists_on_user_id"
  end

  create_table "arts", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.date "completion_date"
    t.text "inspiration"
    t.boolean "available"
    t.bigint "artist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "likees_count", default: 0
    t.string "styles"
    t.integer "price_cents", default: 0, null: false
    t.string "kind"
    t.string "sku"
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

  create_table "carts", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.integer "author_id"
    t.integer "receiver_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.string "favoritable_type", null: false
    t.bigint "favoritable_id", null: false
    t.string "favoritor_type", null: false
    t.bigint "favoritor_id", null: false
    t.string "scope", default: "favorite", null: false
    t.boolean "blocked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blocked"], name: "index_favorites_on_blocked"
    t.index ["favoritable_id", "favoritable_type"], name: "fk_favoritables"
    t.index ["favoritable_type", "favoritable_id"], name: "index_favorites_on_favoritable_type_and_favoritable_id"
    t.index ["favoritor_id", "favoritor_type"], name: "fk_favorites"
    t.index ["favoritor_type", "favoritor_id"], name: "index_favorites_on_favoritor_type_and_favoritor_id"
    t.index ["scope"], name: "index_favorites_on_scope"
  end

  create_table "followers", force: :cascade do |t|
    t.bigint "artist_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_followers_on_artist_id"
    t.index ["user_id"], name: "index_followers_on_user_id"
  end

  create_table "follows", force: :cascade do |t|
    t.string "followable_type", null: false
    t.bigint "followable_id", null: false
    t.string "follower_type", null: false
    t.bigint "follower_id", null: false
    t.boolean "blocked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followable_id", "followable_type"], name: "fk_followables"
    t.index ["followable_type", "followable_id"], name: "index_follows_on_followable_type_and_followable_id"
    t.index ["follower_id", "follower_type"], name: "fk_follows"
    t.index ["follower_type", "follower_id"], name: "index_follows_on_follower_type_and_follower_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "dialect"
    t.bigint "artist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_languages_on_artist_id"
  end

  create_table "likes", force: :cascade do |t|
    t.string "liker_type"
    t.integer "liker_id"
    t.string "likeable_type"
    t.integer "likeable_id"
    t.datetime "created_at"
    t.index ["likeable_id", "likeable_type"], name: "fk_likeables"
    t.index ["liker_id", "liker_type"], name: "fk_likes"
  end

  create_table "mentions", force: :cascade do |t|
    t.string "mentioner_type"
    t.integer "mentioner_id"
    t.string "mentionable_type"
    t.integer "mentionable_id"
    t.datetime "created_at"
    t.index ["mentionable_id", "mentionable_type"], name: "fk_mentionables"
    t.index ["mentioner_id", "mentioner_type"], name: "fk_mentions"
  end

  create_table "messages", force: :cascade do |t|
    t.text "body"
    t.bigint "conversation_id"
    t.bigint "user_id"
    t.bigint "artist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "read", default: false
    t.index ["artist_id"], name: "index_messages_on_artist_id"
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "state"
    t.string "art_sku"
    t.integer "amount_cents", default: 0, null: false
    t.string "checkout_session_id"
    t.bigint "user_id"
    t.bigint "art_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["art_id"], name: "index_orders_on_art_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "photos", force: :cascade do |t|
    t.bigint "art_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo"
    t.bigint "artist_id"
    t.index ["art_id"], name: "index_photos_on_art_id"
    t.index ["artist_id"], name: "index_photos_on_artist_id"
  end

  create_table "punches", id: :serial, force: :cascade do |t|
    t.integer "punchable_id", null: false
    t.string "punchable_type", limit: 20, null: false
    t.datetime "starts_at", null: false
    t.datetime "ends_at", null: false
    t.datetime "average_time", null: false
    t.integer "hits", default: 1, null: false
    t.index ["average_time"], name: "index_punches_on_average_time"
    t.index ["punchable_type", "punchable_id"], name: "punchable_index"
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
    t.string "name"
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
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "votes", id: :serial, force: :cascade do |t|
    t.string "votable_type"
    t.integer "votable_id"
    t.string "voter_type"
    t.integer "voter_id"
    t.boolean "vote_flag"
    t.string "vote_scope"
    t.integer "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope"
    t.index ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope"
  end

  add_foreign_key "art_tags", "arts"
  add_foreign_key "art_tags", "tags"
  add_foreign_key "artist_tags", "artists"
  add_foreign_key "artist_tags", "tags"
  add_foreign_key "artists", "users"
  add_foreign_key "arts", "artists"
  add_foreign_key "cart_products", "arts"
  add_foreign_key "cart_products", "shopping_carts"
  add_foreign_key "comments", "arts"
  add_foreign_key "comments", "users"
  add_foreign_key "followers", "artists"
  add_foreign_key "followers", "users"
  add_foreign_key "orders", "arts"
  add_foreign_key "orders", "users"
  add_foreign_key "photos", "arts"
  add_foreign_key "shopping_carts", "users"
end

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

ActiveRecord::Schema[7.1].define(version: 2024_05_02_062243) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.bigint "phone_number"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "room_id", null: false
    t.integer "status"
    t.date "from_date"
    t.date "to_date"
    t.integer "booking_days"
    t.integer "total_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_bookings_on_room_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "chat_block_chats", force: :cascade do |t|
    t.string "name"
    t.integer "chat_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chat_block_messages", force: :cascade do |t|
    t.string "message"
    t.integer "sender_id"
    t.integer "receiver_id"
    t.bigint "chat_id"
    t.boolean "is_mark_read"
    t.integer "message_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_chat_block_messages_on_chat_id"
  end

  create_table "chat_block_user_chats", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "chat_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_chat_block_user_chats_on_chat_id"
    t.index ["user_id"], name: "index_chat_block_user_chats_on_user_id"
  end

  create_table "devices", force: :cascade do |t|
    t.string "device_token"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_devices_on_user_id"
  end

  create_table "faq_block_faqs", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.string "title"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "post_block_posts", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "room_id"
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_post_block_posts_on_room_id"
    t.index ["user_id"], name: "index_post_block_posts_on_user_id"
  end

  create_table "post_block_tags", force: :cascade do |t|
    t.bigint "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_post_block_tags_on_room_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.string "location"
    t.integer "max_days"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.float "latitude"
    t.float "longitude"
    t.index ["user_id"], name: "index_rooms_on_user_id"
  end

  create_table "transaction_block_transactions", force: :cascade do |t|
    t.float "total_amount", default: 0.0
    t.float "paid_amount", default: 0.0
    t.string "transaction_status"
    t.bigint "user_id", null: false
    t.bigint "booking_id", null: false
    t.float "refund", default: 0.0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_transaction_block_transactions_on_booking_id"
    t.index ["user_id"], name: "index_transaction_block_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.bigint "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "device_token"
    t.string "stripe_id"
    t.string "stripe_connect_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookings", "rooms"
  add_foreign_key "bookings", "users"
  add_foreign_key "chat_block_messages", "chat_block_chats", column: "chat_id"
  add_foreign_key "chat_block_user_chats", "chat_block_chats", column: "chat_id"
  add_foreign_key "chat_block_user_chats", "users"
  add_foreign_key "devices", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "rooms", "users"
  add_foreign_key "transaction_block_transactions", "bookings"
  add_foreign_key "transaction_block_transactions", "users"
end

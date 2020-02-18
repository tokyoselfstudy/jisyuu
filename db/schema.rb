# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_13_121626) do

  create_table "active_storage_attachments", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "countries_prefs", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "entries", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "room_id", null: false, comment: "room.id"
    t.integer "user_id", null: false, comment: "user.id"
    t.integer "event_id", comment: "event.id"
    t.boolean "is_deleted", default: false, null: false, comment: "削除フラグ true: 削除済み false: デフォルト"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "events", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "user_id", null: false, comment: "user.id"
    t.string "title", default: "", null: false
    t.text "detail", comment: "連絡事項や詳細など"
    t.datetime "event_date", null: false, comment: "開催日時"
    t.datetime "event_end_date", null: false, comment: "終了日時"
    t.string "place_name", default: "", null: false, comment: "開催場所"
    t.string "place_address", comment: "開催場所の住所"
    t.string "place_url", comment: "開催場所のurl"
    t.integer "num_of_applicant", default: 0, null: false, comment: "募集人数"
    t.text "reason", comment: "開催理由"
    t.text "target", comment: "開催対象"
    t.integer "fee", default: 0, comment: "参加費"
    t.boolean "is_deleted", default: false, comment: "削除フラグ"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "events_users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "event_id", null: false, comment: "event.id"
    t.integer "user_id", null: false, comment: "user.id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "room_id", null: false, comment: "room.id"
    t.integer "sender_id", null: false, comment: "メッセージを送ったユーザーID"
    t.text "body", null: false, comment: "メッセージ本文"
    t.boolean "is_deleted", default: false, null: false, comment: "削除フラグ true: 削除済み false: デフォルト"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "messages_receivers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "receiver_id", null: false, comment: "メッセージを受け取ったユーザーのID"
    t.integer "message_id", null: false, comment: "message.id"
    t.boolean "read_status", default: false, null: false, comment: "メッセージの既読フラグ true: 既読 false: 未読"
    t.boolean "is_deleted", default: false, null: false, comment: "削除フラグ true: 削除済み false: デフォルト"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rooms", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "event_id", comment: "event.id"
    t.boolean "is_deleted", default: false, null: false, comment: "削除フラグ true: 削除済み false: デフォルト"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "pref_id"
    t.integer "users_category_id", comment: "users_category.id （ユーザーのカテゴリー）"
    t.integer "users_job_category_id", comment: "users_job_category.id （職業のカテゴリー）"
    t.integer "job_id"
    t.string "family_name"
    t.string "first_name"
    t.string "family_name_kana"
    t.string "first_name_kana"
    t.string "gender", comment: "性別"
    t.string "studying", comment: "勉強している事"
    t.text "introduction", comment: "自己紹介"
    t.date "birthdate", comment: "誕生日"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.boolean "is_manager", default: false, null: false, comment: "イベントが作成可能か？ true: 作成可能 false: デフォルト"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users_job_categories", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end

class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.integer :room_id, null: false, comment: 'room.id'
      t.integer :sender_id, null: false, comment: 'メッセージを送ったユーザーID'
      t.text :body, null: false, comment: 'メッセージ本文'
      t.boolean :is_deleted, null: false, default: false, comment: '削除フラグ true: 削除済み false: デフォルト'

      t.timestamps
    end
  end
end

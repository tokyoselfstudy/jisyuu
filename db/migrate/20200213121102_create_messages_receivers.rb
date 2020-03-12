class CreateMessagesReceivers < ActiveRecord::Migration[6.0]
  def change
    create_table :messages_receivers do |t|
      t.integer :receiver_id, null: false, comment: 'メッセージを受け取ったユーザーのID'
      t.integer :message_id, null: false, comment: 'message.id'
      t.boolean :read_status, null: false, default: false, comment: 'メッセージの既読フラグ true: 既読 false: 未読'
      t.boolean :is_deleted, null: false, default: false, comment: '削除フラグ true: 削除済み false: デフォルト'

      t.timestamps
    end
  end
end

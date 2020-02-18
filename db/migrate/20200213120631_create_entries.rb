class CreateEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :entries do |t|
      t.integer :room_id, null: false, comment: 'room.id'
      t.integer :user_id, null: false, comment: 'user.id'
      t.integer :event_id, comment: 'event.id'
      t.boolean :is_deleted, null: false, default: false, comment: '削除フラグ true: 削除済み false: デフォルト'

      t.timestamps
    end
  end
end

class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.integer :event_id, comment: 'event.id'
      t.boolean :is_deleted, null: false, default: false, comment: '削除フラグ true: 削除済み false: デフォルト'

      t.timestamps
    end
  end
end

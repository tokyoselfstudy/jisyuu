class CreateLearnRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :learn_records do |t|
      t.string :title, null: false, default: '', comment: 'タイトル'
      t.integer :user_id, comment: 'user.id'
      t.integer :event_id, comment: 'event.id'
      t.integer :study_category_id, comment: 'study_category.id'
      t.boolean :is_published, default: true, comment: '公開フラグ'
      t.boolean :is_deleted, default: false, comment: '削除フラグ'

      t.timestamps
    end
    add_index :learn_records, :user_id
    add_index :learn_records, :event_id
    add_index :learn_records, :study_category_id
    add_index :learn_records, :is_published
    add_index :learn_records, :is_deleted
  end
end

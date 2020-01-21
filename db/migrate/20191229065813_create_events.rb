class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.integer :user_id, null: false, comment: 'user.id'
      t.string :title, null: false, default: ''
      t.text :detail, comment: '連絡事項や詳細など'
      t.datetime :event_date, null: false, comment: '開催日時'
      t.datetime :event_end_date, null: false, comment: '終了日時'
      t.string :place_name, null: false, default: '', comment: '開催場所'
      t.string :place_address, comment: '開催場所の住所'
      t.string :place_url, comment: '開催場所のurl'
      t.integer :num_of_applicant, null: false, default: 0, comment: '募集人数'
      t.text :reason, comment: '開催理由'
      t.text :target, comment: '開催対象'
      t.integer :fee, default: 0, comment: '参加費'
      t.boolean :is_deleted, default: false, comment: '削除フラグ' 

      t.timestamps
    end
  end
end

class CreateBlogs < ActiveRecord::Migration[6.0]
  def change
    create_table :blogs do |t|
      t.string :title, null: false, default: '', comment: 'タイトル'
      t.boolean :is_published, default: true, comment: '公開フラグ'
      t.boolean :is_deleted, default: false, comment: '削除フラグ'

      t.timestamps
    end
  end
end

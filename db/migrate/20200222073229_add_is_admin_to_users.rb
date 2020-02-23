class AddIsAdminToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_admin, :boolean, after: :is_manager, null: false, default: false, comment: '管理人フラグ true: 管理人 false: デフォルト'
  end
end

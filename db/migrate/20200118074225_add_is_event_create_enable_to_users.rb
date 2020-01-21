class AddIsEventCreateEnableToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :is_manager, :boolean, null: false, default: false, after: :unconfirmed_email, comment: 'イベントが作成可能か？ true: 作成可能 false: デフォルト'
  end
end

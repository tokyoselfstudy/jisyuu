class AddProfileToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :studying, :string, after: :gender, comment: '勉強している事'
    add_column :users, :introduction, :text, after: :studying, comment: '自己紹介'
  end
end

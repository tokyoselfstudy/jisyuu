class AddSnsAccountsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :twitter, :string, after: :birthdate, comment: 'Twitterアカウント'
    add_column :users, :instagram, :string, after: :twitter, comment: 'Instagramアカウント'
  end
end

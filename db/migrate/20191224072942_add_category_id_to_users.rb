class AddCategoryIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :users_category_id, :integer, after: :pref_id, comment: 'users_category.id （ユーザーのカテゴリー）'
    add_column :users, :users_job_category_id, :integer, after: :users_category_id, comment: 'users_job_category.id （職業のカテゴリー）'
  end
end

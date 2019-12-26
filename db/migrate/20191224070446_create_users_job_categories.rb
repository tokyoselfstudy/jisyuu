class CreateUsersJobCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :users_job_categories do |t|
      t.string :name

      t.timestamps
    end
  end
end

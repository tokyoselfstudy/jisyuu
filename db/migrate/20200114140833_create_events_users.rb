class CreateEventsUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :events_users do |t|
      t.integer :event_id, null: false, comment: 'event.id'
      t.integer :user_id, null: false, comment: 'user.id'

      t.timestamps
    end
  end
end

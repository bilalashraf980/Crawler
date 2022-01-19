class CreateUserSessions < ActiveRecord::Migration[7.0]
  def change
    create_table :user_sessions do |t|
      t.belongs_to :user,foreign_key: true,index: true
      t.string  :auth_token
      t.string  :device_token
      t.string  :session_status
      t.timestamps
    end
  end
end

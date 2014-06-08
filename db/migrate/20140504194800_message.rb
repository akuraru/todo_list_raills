class Message < ActiveRecord::Migration
  def change
  	add_column :messages, :user_id, :string
  end
end

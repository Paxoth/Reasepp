class CreateMessageUser < ActiveRecord::Migration
  def change
    create_table :messages_users do |t|
    	t.references :message, index: true
    	t.references :user, index: true
    	t.timestamps
    end
  end
end

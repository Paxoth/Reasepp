class DropWrongTables < ActiveRecord::Migration
  #desde este minuto comenzó el trabajo de memoria de Maximiliano Pérez (2017)
  def up
    drop_table :communities
    drop_table :categories
    drop_table :messages
    drop_table :messages_users
  	drop_table :comment_requests
  	drop_table :comment_offerings
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
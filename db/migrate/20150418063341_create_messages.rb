class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
    	t.string :matters
    	t.text :text
    	t.timestamps
    	t.references :user
    end
  end
end

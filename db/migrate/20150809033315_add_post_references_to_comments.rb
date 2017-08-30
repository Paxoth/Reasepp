class AddPostReferencesToComments < ActiveRecord::Migration
  def change
  	remove_column :comments, :event_id
  	add_reference :comments, :post, polymorphic: true, index: true
  end
end

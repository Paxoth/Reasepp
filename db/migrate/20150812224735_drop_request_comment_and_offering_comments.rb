class DropRequestCommentAndOfferingComments < ActiveRecord::Migration
  def down
  	drop_table :comment_requests
  	drop_table :comment_offerings
  end
end

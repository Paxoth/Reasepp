class CreateCommentRequests < ActiveRecord::Migration
  def change
    create_table :comment_requests do |t|
      t.references :user, index: true, foreign_key: true
      t.references :request, index: true, foreign_key: true
      t.text :body

      t.timestamps null: false
    end
  end
end

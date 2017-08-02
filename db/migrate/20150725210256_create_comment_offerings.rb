class CreateCommentOfferings < ActiveRecord::Migration
  def change
    create_table :comment_offerings do |t|
      t.references :user
      t.references :offering
      t.text :body

      t.timestamps null: false
    end
  end
end

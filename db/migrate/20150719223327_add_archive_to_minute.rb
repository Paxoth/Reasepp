class AddArchiveToMinute < ActiveRecord::Migration
  def change
  	add_attachment  :minutes,:archive
  end
end

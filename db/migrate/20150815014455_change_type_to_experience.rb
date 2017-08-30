class ChangeTypeToExperience < ActiveRecord::Migration
	def up
		change_column :experiences, :frequency, :text
		change_column :experiences, :weekly_hours, :text
		change_column :experiences, :benefit, :text
		change_column :experiences, :students_level, :text
		change_column :experiences, :professor_degree, :integer
		remove_reference :experiences, :offering
		remove_reference :experiences, :request
		add_reference :experiences, :service
		remove_column :experiences, :folio
		add_column  :experiences, :start_time, :date
		add_column  :experiences, :end_time, :date
		remove_reference :experiences, :user
		add_reference :experiences, :professor
		add_reference :experiences, :partner
	end
	def down
		change_column :experiences, :frequency, :integer
		change_column :experiences, :weekly_hours, :integer
		change_column :experiences, :benefit, :integer
		change_column :experiences, :students_level, :integer
		change_column :experiences, :professor_degree, :text
		add_reference :experiences, :offering
		add_reference :experiences, :request
		remove_reference :experiences, :service
		add_column :experiences, :folio, :integer
		remove_column  :experiences, :start_time, :date
		remove_column  :experiences, :end_time, :date
		add_reference :experiences, :user
		remove_reference :experiences, :professor
		remove_reference :experiences, :partner
	end
end

class ChangeColumnsToExperiences < ActiveRecord::Migration
  def change
  	remove_column :experiences, :weekly_hours, :text
  	remove_column :experiences, :benefit, :text
  	add_column :experiences, :weekly_hours, :integer, default:0
  	add_column :experiences, :benefited, :integer, default:0
    remove_column :experiences, :institutional_support, :integer
    remove_column :experiences, :professor_name, :integer
    remove_column :experiences, :professor_email, :integer
    add_column :experiences, :partner_name, :text
  end
end

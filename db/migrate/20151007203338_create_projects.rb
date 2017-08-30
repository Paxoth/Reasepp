class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.text :description
      t.text :faculty
      t.text :department
      t.text :course_name
      t.text :course_type
      t.text :course_type_other
      t.text :professor_name
      t.text :professor_phone
      t.text :professor_email
      t.text :learning_objectives
      t.text :service_objectives
      t.text :frequency
      t.text :weekly_hours
      t.text :students_level
      t.text :community_partner
      t.text :organization_type
      t.text :benefit
      t.text :results
      t.text :tools
      t.text :reflection_moments
      t.integer :period
      t.integer :professor_degree
      t.integer :participants
      t.integer :institutional_support
      t.references :area, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.references :institution, index: true, foreign_key: true
      t.date :start_time
      t.date :end_time
      t.text :partner

      t.timestamps null: false
    end
  end
end

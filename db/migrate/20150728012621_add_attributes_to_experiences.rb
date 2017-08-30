class AddAttributesToExperiences < ActiveRecord::Migration
	def change
		change_table :experiences do |t|
			t.integer :folio
			t.remove :tittle
			t.string :title
			t.remove :service_offering_id
			t.references :offering
			t.references :institution
			t.text :faculty
			t.text :department
			t.text :course_name
			t.text :course_type
			t.text :course_type_other
			t.integer :period
			t.text :professor_name
			t.text :professor_email
			t.text :professor_phone
			t.text :professor_degree
			t.text :learning_objectives
			t.text :service_objectives
			t.integer :institutional_support
			t.integer :frequency
			t.integer :weekly_hours
			t.integer :participants
			t.integer :students_level
			t.text :community_partner
			t.text :organization_type
			t.text :benefit
			t.text :results
			t.text :tools
			t.text :reflection_moments
		end		
	end
end

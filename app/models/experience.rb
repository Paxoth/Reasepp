class Experience < ActiveRecord::Base
	belongs_to :professor, :class_name=> "User"
	belongs_to :partner, :class_name=> "User"

	belongs_to :institution
	belongs_to :area

	belongs_to :service

	#validates :description, :length => {
	#	:minimum   => 1,
	#	:maximum   => 100,
	#	:tokenizer => lambda { |str| str.split },
	#	:too_short => "Debe tener por lo menos %{count} palabra",
	#	:too_long  => "Debe tener máximo %{count} palabras"
	#}

	def self.search(search)
		where("faculty LIKE ? or department LIKE ? or course_name LIKE ? or course_type LIKE ? or period LIKE ? or learning_objectives LIKE ? or service_objectives LIKE ? or benefit LIKE ? or results LIKE ? or tools LIKE ? or description LIKE ? or reflection_moments LIKE ? or title LIKE ?", "%#{search}%","%#{search}%", "%#{search}%", "%#{search}%","%#{search}%", "%#{search}%", "%#{search}%","%#{search}%", "%#{search}%", "%#{search}%","%#{search}%", "%#{search}%" , "%#{search}%") 
	end
end
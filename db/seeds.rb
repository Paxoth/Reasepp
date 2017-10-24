# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Area.destroy_all
Institution.destroy_all
InterestLink.destroy_all
Resource.destroy_all

Offering.destroy_all
Request.destroy_all
Service.destroy_all
Experience.destroy_all


User.create([{
	email: 'coordinacion.rease@gmail.com',
	password: 'rease2015',
	name: 'Coordinación',
	nickname: 'Admin', 
	category: 1, 
	autorization_level: 1, 
	confirmed_at: Time.now,
}])
print("\tSeed:\tUsuario Administrador creado\n")

usuarios_prueba_list =[
	["profesor@rease.cl",'rease2015', 'profesor Prueba', 'profesor', 2, 1],
	["vinculador@rease.cl",'rease2015', 'Vinculador Prueba', 'Vinculador', 3, 1],
	["socio@rease.cl",'rease2015', 'Socio Prueba', 'Socio',4,1]
]

usuarios_prueba_list.each do |email, password, name, nickname, category, autorization_level|
  User.create( email: email, password: password, name: name, nickname: nickname, category: category, autorization_level:autorization_level, confirmed_at: Time.now)
end
print("\tSeed:\tUsuarios profesor, Vinculador y Socio Comunitario creados\n")


area_list = [
	[1,"Ciencias Naturales","Matemáticas","Disciplina: Ciencias Naturales"],
	[2,"Ciencias Naturales","Computación y Ciencias de la Información","Disciplina: Ciencias Naturales"],
	[3,"Ciencias Naturales","Ciencias Físicas","Disciplina: Ciencias Naturales"],
	[4,"Ciencias Naturales","Ciencias Químicas","Disciplina: Ciencias Naturales"],
	[5,"Ciencias Naturales","Ciencias de la Tierra y Medioambientales","Disciplina: Ciencias Naturales"],
	[6,"Ciencias Naturales","Ciencias Biológicas","Disciplina: Ciencias Naturales"],
	[7,"Ciencias Naturales","Otras Ciencias Naturales","Disciplina: Ciencias Naturales"],
	[8,"Ingeniería y Tecnología","Ingeniería Civil","Disciplina: Ingeniería y Tecnología"],
	[9,"Ingeniería y Tecnología","Ingeniería Eléctrica, Electrónica e Informática","Disciplina: Ingeniería y Tecnología"],
	[10,"Ingeniería y Tecnología","Ingeniería Mecánica","Disciplina: Ingeniería y Tecnología"],
	[11,"Ingeniería y Tecnología","Ingeniería Química","Disciplina: Ingeniería y Tecnología"],
	[12,"Ingeniería y Tecnología","Ingeniería de los Materiales","Disciplina: Ingeniería y Tecnología"],
	[13,"Ingeniería y Tecnología","Ingeniería Médica","Disciplina: Ingeniería y Tecnología"],
	[14,"Ingeniería y Tecnología","Ingeniería Ambiental","Disciplina: Ingeniería y Tecnología"],
	[15,"Ingeniería y Tecnología","Biotecnología Ambiental","Disciplina: Ingeniería y Tecnología"],
	[16,"Ingeniería y Tecnología","Biotecnología Industrial","Disciplina: Ingeniería y Tecnología"],
	[17,"Ingeniería y Tecnología","Nanotecnología","Disciplina: Ingeniería y Tecnología"],
	[18,"Ingeniería y Tecnología","Otras Ingeniería y Tecnologías","Disciplina: Ingeniería y Tecnología"],
	[19,"Ciencias Médicas y de la Salud","Medicina Básica","Disciplina: Ciencias Médicas y de la Salud"],
	[20,"Ciencias Médicas y de la Salud","Medicina Clínica","Disciplina: Ciencias Médicas y de la Salud"],
	[21,"Ciencias Médicas y de la Salud","Ciencias de la Salud","Disciplina: Ciencias Médicas y de la Salud"],
	[22,"Ciencias Médicas y de la Salud","Biotecnología en Salud","Disciplina: Ciencias Médicas y de la Salud"],
	[23,"Ciencias Médicas y de la Salud","Otras Ciencias Médicas","Disciplina: Ciencias Médicas y de la Salud"],
	[24,"Ciencias Agrícolas","Agricultura, Silvicultura y Pesca","Disciplina: Ciencias Agrícolas"],
	[25,"Ciencias Agrícolas","Ciencias Animales y Lácteos","Disciplina: Ciencias Agrícolas"],
	[26,"Ciencias Agrícolas","Ciencias Veterinarias","Disciplina: Ciencias Agrícolas"],
	[27,"Ciencias Agrícolas","Biotecnología Agrícola","Disciplina: Ciencias Agrícolas"],
	[28,"Ciencias Agrícolas","Otras Ciencias Agrícolas","Disciplina: Ciencias Agrícolas"],
	[29,"Ciencias Sociales","Psicología","Disciplina: Ciencias Sociales"],
	[30,"Ciencias Sociales","Economía y Negocios","Disciplina: Ciencias Sociales"],
	[31,"Ciencias Sociales","Ciencias de la Educación","Disciplina: Ciencias Sociales"],
	[32,"Ciencias Sociales","Sociología","Disciplina: Ciencias Sociales"],
	[33,"Ciencias Sociales","Leyes","Disciplina: Ciencias Sociales"],
	[34,"Ciencias Sociales","Ciencias Políticas","Disciplina: Ciencias Sociales"],
	[35,"Ciencias Sociales","Geografía Social y Económica","Disciplina: Ciencias Sociales"],
	[36,"Ciencias Sociales","Periodismo y Comunicaciones","Disciplina: Ciencias Sociales"],
	[37,"Ciencias Sociales","Otras Ciencias Sociales","Disciplina: Ciencias Sociales"],
	[38,"Humanidades","Historia y Arqueología","Disciplina: Humanidades"],
	[39,"Humanidades","Idiomas y Literatura","Disciplina: Humanidades"],
	[40,"Humanidades","Filosofía, Ética y Religión","Disciplina: Humanidades"],
	[41,"Humanidades","Arte, Historia del Arte, Arquitectura, Música, Cine, Radio y
TV","Disciplina: Humanidades"],
	[42,"Humanidades","Otras Humanidades","Disciplina: Humanidades"]
]

area_list.each do |id, discipline, name, description|
  Area.create(id: id, discipline: discipline, name: name, description: description )
end

print("\tSeed:\tAreas de trabajo creadas\n")


institution_list = [
	[1,"#{Rails.root}/public/institution/hdc.png", "Hogar de Cristo", "http://www.hogardecristo.cl/"],
	[2,"#{Rails.root}/public/institution/maristas.png", "Maristas Chile", "http://www.maristas.cl/"],
	[3,"#{Rails.root}/public/institution/puc.png", "Pontificia Universidad Católica de Chile", "http://www.uc.cl/"],
	[4,"#{Rails.root}/public/institution/uhurtado.png", "Universidad Alberto Hurtado", "http://www.uahurtado.cl/fernando-vives-sj/"],
	[5,"#{Rails.root}/public/institution/unab.png", "Universidad Andrés Bello", "http://www.unab.cl/"],
	[6,"#{Rails.root}/public/institution/uaustral.png", "Universidad Austral de Chile", "https://www.uach.cl/"],
	[7,"#{Rails.root}/public/institution/utemuco.png", "Universidad Católica de Temuco", "http://www.uctemuco.cl/"],
	[8,"#{Rails.root}/public/institution/pucv.png", "Universidad Católica de Valparaíso", "http://www.ucv.cl/"],
	[9,"#{Rails.root}/public/institution/usilvahenriquez.png", "Universidad Católica Silva Henríquez", "http://ww3.ucsh.cl/"],
	[10,"#{Rails.root}/public/institution/ucentral.png", "Universidad Central", "http://www.ucentral.cl/"],
	[11,"#{Rails.root}/public/institution/uchile.png", "Universidad de Chile", "http://www.uchile.cl/"],
	[12,"#{Rails.root}/public/institution/uconce.gif", "Universidad de Concepción", "http://www.udec.cl/pexterno/"],
	[13,"#{Rails.root}/public/institution/ufro.png", "Universidad de la Frontera", "http://www.ufro.cl/"],
	[14,"#{Rails.root}/public/institution/usach.png", "Universidad de Santiago de Chile", "http://rsu.usach.cl/"]
]

institution_list.each do |id, logo,name, web|
  	Institution.create(id: id, logo: File.new(logo), name: name, web: web)
end
print("\tSeed:\tInstuciones creadas\n")

interestLinks_list = [
	["RIDAS","http://revistes.ub.edu/index.php/RIDAS","Revista Iberoamericana de Aprendizaje Servicio"],
	["National Service-Learning Clearinghouse","https://gsn.nylc.org/","Centro Aprendizaje Servicio en USA"],
	["Zerbikas","http://www.zerbikas.es/","Centro Promotor del Aprendizaje y Servicio Solidario en Euskadi ZERBIKAS"],
	["REASE en youtube (Tutoriales aplicación)","https://www.youtube.com/channel/UCO3xgzmdu9EWKVGJO1Yj4rA","Tutoriales para poder usar la aplicación sin documentación o capacitación previa"],
	["El aprendizaje-servicio por Andrew Furco","http://educacionglobalresearch.net/wp-content/uploads/03-Furco-1-Castellano.pdf","El aprendizaje-servicio por Andrew Furco"],
	["CLAYSS en youtube","https://www.youtube.com/channel/UCfjT6MIfaghMrdw7NCDICcQ","Videos de CLAYSS en youtube"],
	["CLAYSS","http://www.clayss.org.ar","Centro Latinoamericano de Aprendizaje y Servicio"],
	["Facebook REASE Chile","https://es-es.facebook.com/reasechile","Página de facebook de la red nacional de aprendizaje servicio"]
]

interestLinks_list.each do |name,url, description|
  	InterestLink.create(name: name, url: url, description: description)
end
print("\tSeed:\tEnlances de Interes creados\n")


actas_list = [
 [1,"#{Rails.root}/public/resources/actas/2014_04_10_ampliada.pdf", "Acta reunión ampliada 1", "2014-04-10", "Acta de reunión ampliada 2014-04-10"],
 [2,"#{Rails.root}/public/resources/actas/2014_07_11_ampliada.pdf", "Acta reunión ampliada 2", "2014-07-11", "Acta de reunión ampliada 2014-07-11"],
 [3,"#{Rails.root}/public/resources/actas/2014_09_12_ampliada.pdf", "Acta reunión ampliada 3", "2014-09-12", "Acta de reunión ampliada 2014-09-12"],
 [4,"#{Rails.root}/public/resources/actas/2014_11_07_ampliada.pdf", "Acta reunión ampliada 4", "2014-11-07", "Acta de reunión ampliada 2014-11-07"],
 [5,"#{Rails.root}/public/resources/actas/2015_04_10.pdf", "Acta reunión ampliada 5", "2015-04-10", "Acta de reunión ampliada 2015-04-10"],
 [6,"#{Rails.root}/public/resources/actas/2015_06_05_ampliada.pdf", "Acta reunión ampliada 6", "2015-06-05", "Acta de reunión ampliada 2015-06-05"]
]

actas_list.each do |id, archive,name, date, description|
 Resource.create(id:id, archive: File.new(archive), name: name, date: date, description: description, category: 1)
end

print("\tSeed:\tRecursos creados y subidos\n")

print("\nGENERACIÓN DE DATOS DUMMIES PARA LAS PRUEBAS DE INFORMACIÓN DE GESTION DE LA INSTITUCIÓN\n")

print("\n\tSeed:\tCreando profesores: ")
(1..100).step(1) do |n|
	User.create(
		email: "profesor"+n.to_s+"@rease.cl",
		password: 'rease2017',
		name: "profesor Prueba "+n.to_s,
		nickname: "Profe"+n.to_s,
		category: 2, 
		autorization_level: 1, 
		confirmed_at: Time.now,
		institution_id: rand(1..14)
	)
	print(User.last.id.to_s+" ")
end
print("\n\tSeed:\tprofesores de pruebas creados [100=>5-104]\n")

print("\n\tSeed:\tCreando socios: ")
(1..100).step(1) do |n|
	User.create(
		email: "socio"+n.to_s+"@rease.cl",
		password: 'rease2017',
		name: "Socio Prueba "+n.to_s,
		nickname: "Socio"+n.to_s,
		category: 4, 
		autorization_level: 1, 
		confirmed_at: Time.now,
		institution_id: rand(1..14)
	)
	print(User.last.id.to_s+" ")
end
print("\n\tSeed:\tSocios de pruebas creados [100=>105-204] \n")


print("\n\tSeed:\tCreando ofertas con usuarios: ")
(1..100).step(1) do |n|
	professor_aux_id = rand(5..104)
	print(professor_aux_id.to_s+" ")
	professor_aux = User.where(id:professor_aux_id).first #UN professor al azar
	Offering.create(
		id: n, 
		user_id: professor_aux.id, 
		title: "Oferta de prueba generada por seed #"+n.to_s, 
		description: "Descripción de Oferta de Servicio de prueba generada por seed #"+n.to_s, 
		start_time: Time.now, 
		end_time: Time.now+(rand*(20+n)).days, 
		resume: "Resumen de prueba generada por seed #"+n.to_s, 
		status: 1, 
		area_id: (rand*42), 
		location: "Ubicación de prueba generada por seed #"+n.to_s, 
		institution_id: professor_aux.institution_id
	)
end
print("\n\tSeed:\tOfertas de pruebas creadas [100]\n")

print("\n\tSeed:\tCreando solicitudes con usuarios: ")
(1..100).step(1) do |n|
	partner_aux_id = rand(105..204)
	print(partner_aux_id.to_s+" ")
	partner_aux = User.where(id:partner_aux_id).first 	#Un socio al aazar
	Request.create(
		id: n, 
		user_id: partner_aux.id, 
		title: "Solicitud de prueba generada por seed #"+n.to_s, 
		description: "Descripción de Solicitud de Servicio de prueba generada por seed #"+n.to_s, 
		start_time: Time.now, 
		end_time: Time.now+(rand*(20+n)).days, 
		resume: "Resumen de prueba generada por seed #"+n.to_s, 
		status: 1, 
		area_id: rand(1..42), 
		location: "Ubicación de prueba generada por seed #"+n.to_s, 
		institution_id: partner_aux.institution_id
	)
end
print("\n\tSeed:\tSolicitud de pruebas creadas [100] \n")

(1..100).step(1) do |n|
	professor_aux_id = rand(5..104)
	professor_aux = User.where(id: professor_aux_id).first 	#Un professor al azar
	partner_aux_id = rand(105..204)
	partner_aux = User.where(id: partner_aux_id).first		#Un socio al azar
	if n%2!=0 #ESTA CONDICION SE PUEDE CAMBIAR
		publication_aux = Request.where(id: n).first		
		Service.create( #BASADOS EN REQUEST
			id: n, 
			publication_id: publication_aux.id, 
			publication_type: "Request", 
			creator_id: professor_aux.id, #Creador de servicio, no de la solicitud
			acceptor_id: publication_aux.user_id, #Creador de la solicitud
			area_id: publication_aux.area_id, 
			institution_id: publication_aux.institution_id, 
			title: "Servicio basado en solicitud de prueba generada por seed #"+publication_aux.id.to_s, 
			status: 4,
			message: "Mensaje de prueba de servicio #"+n.to_s, 
			description: "Descripción de del Servicio basado en Solicitud de prueba por seed #"+publication_aux.id.to_s,
			resume: "Resumen de prueba del Servicio generado basado en Solicitud por seed #"+publication_aux.id.to_s, 
			start_time: publication_aux.start_time+5.days, 
			end_time: publication_aux.end_time+5.days, 
			learning_objectives: "Objetivos de Aprendizaje del Servicio basado en solicitud #"+n.to_s, 
			service_objectives: "Objetivos de Servicio del Servicio basado en solicitud #"+n.to_s
		)
	else
		publication_aux = Offering.where(id: n).first
		Service.create( #BASADOS EN OFFERING
			id: n, 
			publication_id: publication_aux.id, 
			publication_type: "Offering", 
			creator_id: partner_aux.id, #Creador del servicio, no de la oferta
			acceptor_id: publication_aux.user_id, #Creador de la oferta
			area_id: publication_aux.area_id, 
			institution_id: publication_aux.institution_id, 
			title: "Servicio basado en la Oferta de prueba generada por seed #"+publication_aux.id.to_s, 
			status: 4,
			message: "Mensaje de prueba de servicio #"+n.to_s, 
			description: "Descripción de del Servicio basado en Oferta de prueba por seed #"+publication_aux.id.to_s,
			resume: "Resumen de prueba del Servicio generado basado en Oferta por seed #"+publication_aux.id.to_s, 
			start_time: publication_aux.start_time+5.days, 
			end_time: publication_aux.end_time+5.days, 
			learning_objectives: "Objetivos de Aprendizaje del Servicio basado en oferta #"+n.to_s, 
			service_objectives: "Objetivos de Servicio del Servicio basado en oferta #"+n.to_s
		)
	end
	publication_aux.status = 4 #Con esto la oferta o la soliitud pasa al estado de servicio
	publication_aux.save
end
print("\tSeed:\tServicios de pruebas creadas basadas las ofertas y solicitudes de prueba [100] \n")

exp_id = 0
(1..100).step(2) do |n| #ESTA CONDICION SE PUEDE CAMBIAR
	service_aux = Service.where(id:n).first
	if service_aux.publication_type = "Request"
		professor_aux = User.where(id:service_aux.creator_id).first
		partner_aux = User.where(id: service_aux.acceptor_id).first
	else
		partner_aux = User.where(id:service_aux.creator_id).first
		professor_aux = User.where(id: service_aux.acceptor_id).first
	end
	exp_id += 1 
	Experience.create(
		id: exp_id,
		description: "Descripción basada en servicio #"+service_aux.id.to_s,
		title: "Experiencia basada en servicio #"+service_aux.id.to_s,
		institution_id: service_aux.institution_id,
		faculty: "Facultad de prueba Experiencia basada en servicio #"+service_aux.id.to_s,
		department: "Departamento de prueba para Experiencia basada en servicio #"+service_aux.id.to_s,
		course_name: "Curso de prueba para Experiencia basada en servicio #"+service_aux.id.to_s,
		course_type: ["Obligatorio", "Optativo", "Electivo"].sample,
		course_type_other: nil,	
		period: rand(1..4),
		professor_phone: "+56987654321",
		professor_degree: rand(1..3),
		learning_objectives: service_aux.learning_objectives,
		service_objectives: service_aux.service_objectives,
		frequency: "Frecuencia e Experiencia basada en servicio #"+service_aux.id.to_s,
		weekly_hours: rand(8..48),
		participants: rand(5..40),
		students_level: "Nivel de estudiantes Experiencia basada en servicio #"+service_aux.id.to_s,
		community_partner: partner_aux.name,
		organization_type:	"Organizacion para Experiencia basada en servicio #"+service_aux.id.to_s,
		benefited: rand(5..40),
		results: "Resultados de aprendizaje para Experiencia basada en servicio #"+service_aux.id.to_s,
		tools: "Herramientas de medicion para Experiencia basada en servicio #"+service_aux.id.to_s,
		reflection_moments: "Momentos de reflexión Experiencia basada en servicio #"+service_aux.id.to_s,
		area_id: service_aux.area_id,
		service_id:	service_aux.id,
		start_time:	service_aux.start_time,
		end_time: service_aux.end_time,
		professor_id: professor_aux.id,
		partner_id: partner_aux.id,
	)
	service_aux.status = 5 #Con esto el servicio pasa a estado de experiencia
	service_aux.save
end
print("\tSeed:\tExperiencias de pruebas creadas [50]\n")


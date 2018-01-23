print("============================")
print("\n SEED PARA PRESENTACIÓN \n")
print("============================\n\n")

User.create([{
	email: 'coordinacion.rease@gmail.com',
	password: 'rease2017',
	name: 'Coordinación',
	nickname: 'Admin', 
	category: 2, 
	autorization_level: 1, 
	confirmed_at: Time.now,
	is_admin: true,
}])
print("\tSeed:\tUsuario Administrador creado\n")

usuarios_prueba_list =[
	["profesor@rease.cl",'rease2017', 'profesor Prueba', 'profesor', 2, 1, "#{Rails.root}/public/fotos/Profesor.png"],
	["vinculador@rease.cl",'rease2017', 'Vinculador Prueba', 'Vinculador', 3, 1, "#{Rails.root}/public/fotos/Vinculador.png"],
	["socio@rease.cl",'rease2017', 'Socio Prueba', 'Socio',4,1, "#{Rails.root}/public/fotos/Socio.png"]
]

usuarios_prueba_list.each do |email, password, name, nickname, category, autorization_level, archive|
  User.create( email: email, password: password, name: name, nickname: nickname, category: category, autorization_level:autorization_level, confirmed_at: Time.now, photo: File.new(archive))
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
	[14,"#{Rails.root}/public/institution/usach.png", "Universidad de Santiago de Chile", "http://rsu.usach.cl/"],
	[15,"#{Rails.root}/public/institution/umayor.png", "Universidad Mayor", "http://www.umayor.cl/"],
	[16,"#{Rails.root}/public/institution/utem.png", "Universidad Técnica Metropolitana", "http://www.utem.cl/"],
	
]

institution_list.each do |id, logo,name, web|
  	Institution.create(id: id, logo: File.new(logo), name: name, web: web)
end
print("\tSeed:\tInstuciones creadas\n")

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

Institution.all.each do |institution|
	institution.created_at = Time.now+(rand*(30)).days-(rand(5..40)).months
	institution.save
end

print("\nGENERACIÓN DE DATOS DUMMIES PARA LAS PRUEBAS DE INFORMACIÓN DE GESTION DE LA INSTITUCIÓN\n")


print("\nINSERTANDO TEXTOS BASES PARA POBLAR SISTEMA\n")

texto_list=[
	[1, "Damos inicio a la nueva intranet de REASE", "Se ha creado una nueva intranet en rease en donde la prioridad está enfocada en ser un repositorios de experiencias realizadas por toda la organización. Se espera que con estos cambios, los usuarios puedan utilizar de mejor manera la plataforma."],
	[2, "¡Nuevas vistas!", "Ahora todas las actividades AS (Ofertas, Solicitudes, Servicios Activos y Experiencias) se despliegan a través de Datatables, tablas las cuales puedes ordenar su componente y hacen sus vistas mucho más amigables!"],
	[3, "Instituciones mejoradas", "Con la última actualización de la intranet de REASE, ahora existe una página de institución, en donde los usuarios podrán ver las actividades AS que esta ha realizado a través de su instancia en la RED."]
]

texto_list.each do |id, title, body|
  	Section.create(id: id, title: title, body: body, module: "Novedad", priority: rand(1..3))
end

User.create([{
	email: 'edmundo.leiva@usach.cl',
	password: 'rease2017',
	name: 'Edmundo Leiva Lobos',
	nickname: 'Profe Edmundo', 
	category: 2, 
	autorization_level: 1, 
	confirmed_at: Time.now,
	is_admin: true,
	institution_id: 14,
	institution_custom: true,
	photo: File.new("#{Rails.root}/public/fotos/Edmundo.png")
}])

User.create([{
	email: 'maximiliano.perez@usach.cl',
	password: 'rease2017',
	name: 'Maximiliano Pérez Rodríguez',
	nickname: 'Paxoth', 
	category: 4, 
	autorization_level: 1, 
	confirmed_at: Time.now,
	is_admin: true,
	institution_id: 14,
	institution_custom: true
}])

User.create([{
	email: 'catalina.mujica@umayor.cl',
	password: 'rease2017',
	name: 'Catalina Mujica',
	nickname: 'Catalina', 
	category: 4, 
	autorization_level: 1, 
	confirmed_at: Time.now,
	is_admin: true,
	institution_id: 15,
	institution_custom: false
}])

User.create([{
	email: 'jtmontalva@gmail.com',
	password: 'rease2017',
	name: 'José Tomás Montalva',
	nickname: 'José', 
	category: 4, 
	autorization_level: 1, 
	confirmed_at: Time.now,
	is_admin: true,
	institution_custom: false
}])

User.create([{
	email: 'aprendizajeservicio@uc.cl',
	password: 'rease2017',
	name: 'Manuel Caire Espinoza',
	nickname: 'Manuel', 
	category: 2, 
	autorization_level: 1, 
	confirmed_at: Time.now,
	is_admin: false,
	institution_id: 3,
	institution_custom: false,
	photo: File.new("#{Rails.root}/public/fotos/Manuel.jpg")
}])

User.create([{
	email: 'ralmendras@utem.cl',
	password: 'rease2017',
	name: 'Rocío Almendras',
	nickname: 'Rocío', 
	category: 2, 
	autorization_level: 1, 
	confirmed_at: Time.now,
	is_admin: false,
	institution_id: 16,
	institution_custom: true,
	photo: File.new("#{Rails.root}/public/fotos/Rocio.jpg")
}])

print("\n\tSeed:\tAsignado usuarios básicos cargos dentro de las instituciones")
	profesor = User.where(id:2).first
	socio = User.where(id:3).first
	vinculador = User.where(id:4).first
	profesor.institution_id = 14
	socio.institution_id = 14
	vinculador.institution_id=14
	usach = Institution.where(id:14).first
	utem = Institution.where(id:16).first
	umayor = Institution.where(id:15).first
	puc = Institution.where(id:3).first
	edmundo = User.where(email: "edmundo.leiva@usach.cl").first
	rocio = User.where(email: "ralmendras@utem.cl").first
	manuel = User.where(email: "aprendizajeservicio@uc.cl").first
	catalina = User.where(email: "catalina.mujica@umayor.cl").first
	usach.manager_id = edmundo.id
	utem.manager_id = rocio.id
	umayor.manager_id = catalina.id
	puc.manager_id = manuel.id
	utem.facebook = "https://www.facebook.com/utem.cl"
	utem.instagram = "https://www.instagram.com/utem.cl/"
	utem.linkedin = "https://www.linkedin.com/school/15092438/"
	utem.twitter = "https://twitter.com/utem"
	utem.youtube = "https://www.youtube.com/channel/UCOD3DHD_bafDGzGPYxTtRRw"
	usach.facebook = "https://www.facebook.com/universidaddesantiago/"
	usach.instagram = "https://www.instagram.com/udesantiagocl/"
	usach.linkedin = "https://www.linkedin.com/school/universidad-de-santiago-de-chile/"
	usach.twitter = "https://twitter.com/usach"
	usach.youtube = "https://www.youtube.com/user/digecapusach"
	usach.save
	utem.save
	umayor.save
	puc.save
print("\n\tSeed:\tUsarios básicos asignados a sus instituticiones:")



print("\n\tSeed:\tCreando profesores: ")
(1..10).step(1) do |n| #11..20
	inst_id = rand(1..16)
	inst_aux = Institution.where(id:inst_id).first
	inst_days = (inst_aux.created_at.to_date..Time.now.to_date).count
	user_created = inst_aux.created_at+rand(inst_days-10).days+rand(200).minutes
	User.create(
		email: "profesor"+n.to_s+"@rease.cl",
		password: 'rease2017',
		name: "profesor Prueba "+n.to_s,
		nickname: "Profe"+n.to_s,
		category: 2, 
		created_at: user_created,
		confirmed_at: user_created+2.days,
		autorization_level: 1, 
		institution_id: inst_id
	)
	print(User.last.id.to_s+" ")
end
print("\n\tSeed:\tprofesores de pruebas creados [10=>11-20]\n")

print("\n\tSeed:\tCreando socios: ")
(1..10).step(1) do |n| #21..30
	inst_id = rand(1..16)
	inst_aux = Institution.where(id:inst_id).first
	inst_days = (inst_aux.created_at.to_date..Time.now.to_date).count
	user_created = inst_aux.created_at+rand(inst_days-10).days+rand(200).minutes
	User.create(
		email: "socio"+n.to_s+"@rease.cl",
		password: 'rease2017',
		name: "Socio Prueba "+n.to_s,
		nickname: "Socio"+n.to_s,
		category: 4, 
		created_at: user_created,
		confirmed_at: user_created+2.days,
		autorization_level: 1, 
		institution_id: inst_id
	)
	print(User.last.id.to_s+" ")
end

print("\n\tSeed:\tSocios de pruebas creados [10=>21-30] \n")

print("\n\tSeed:\tCreando Vinculadores: ")
(1..10).step(1) do |n| #31..40
	inst_id = rand(1..16)
	inst_aux = Institution.where(id:inst_id).first
	inst_days = (inst_aux.created_at.to_date..Time.now.to_date).count
	user_created = inst_aux.created_at+rand(inst_days-10).days+rand(200).minutes
	User.create(
		email: "vinculador"+n.to_s+"@rease.cl",
		password: 'rease2017',
		name: "Vinculador Prueba "+n.to_s,
		nickname: "Vinculador"+n.to_s,
		category: 3, 
		created_at: user_created,
		confirmed_at: user_created+2.days,
		autorization_level: 1, 
		institution_id: inst_id
	)
	print(User.last.id.to_s+" ")
end

print("\n\tSeed:\tVinculadores de pruebas creados [10=>31-40] \n")


print("\n\tSeed:\tCreando ofertas con profesores: ")
(1..20).step(1) do |n|
	professor_aux_id = rand(11..20)
	professor_aux = User.where(id:professor_aux_id).first #UN professor al azar
	Offering.create(
		id: n, 
		user_id: professor_aux.id, 
		title: "Oferta de prueba #"+n.to_s, 
		description: "Descripción de Oferta de Servicio de prueba generada por seed #"+n.to_s, 
		created_at: Time.now-rand*(20-40).days,
		start_time: Time.now-rand*(20).days, 
		end_time: Time.now+rand*(20).days, 
		resume: "Resumen de prueba generada por seed #"+n.to_s, 
		status: 1, 
		area_id: rand(1..42), 
		location: "Ubicación de prueba generada por seed #"+n.to_s, 
		institution_id: professor_aux.institution_id
	)
	print(professor_aux_id.to_s+" ")
end
print("\n\tSeed:\tOfertas de pruebas por profesores creadas [20]\n")

print("\n\tSeed:\tCreando ofertas con vinculadores: ")
offering_count = Offering.count
(1..10).step(1) do |n|
	vinculador_aux_id = rand(31..40)
	has_professor = rand(0..2)
	if has_professor == 0
		user_id = vinculador_aux_id
	else
		user_id = rand(11..20)
	end
	dueno = User.where(id:user_id).first
	institution_id = dueno.institution_id
	print(vinculador_aux_id.to_s+" ")
	vinculador_aux = User.where(id:vinculador_aux_id).first 	
	actual_id = offering_count+n
	Offering.create(
		id: actual_id,
		user_id: user_id,
		title: "Oferta de prueba por Vinculador #"+actual_id.to_s, 
		description: "Descripción de Oferta de Servicio por VINCULADOR de prueba generada por seed #"+actual_id.to_s, 
		created_at: Time.now-rand*(20-40).days,
		start_time: Time.now-rand*(20).days,  
		end_time: Time.now+rand*(20).days, 
		resume: "Resumen de Oferta prueba por VINCULADOR generada por seed #"+actual_id.to_s, 
		status: 1, 
		area_id: rand(1..42), 
		location: "Ubicación de Oferta prueba por VINCULADOR generada por seed #"+actual_id.to_s, 
		institution_id: institution_id,
		broker_id: vinculador_aux.id
	)
end
print("\n\tSeed:\tOfertas de servicio por vinculadores creadas [10] \n")

print("\n\tSeed:\tCreando solicitudes con socios: ")
(1..20).step(1) do |n|
	partner_aux_id = rand(21..30)
	print(partner_aux_id.to_s+" ")
	partner_aux = User.where(id:partner_aux_id).first 	#Un socio al aazar
	Request.create(
		id: n, 
		user_id: partner_aux.id, 
		title: "Solicitud de prueba #"+n.to_s, 
		description: "Descripción de Solicitud de Servicio de prueba generada por seed #"+n.to_s, 
		created_at: Time.now-rand*(20-40).days,
		start_time: Time.now-rand*(20).days,  
		end_time: Time.now+rand*(20).days, 
		resume: "Resumen de prueba generada por seed #"+n.to_s, 
		status: 1, 
		area_id: rand(1..42), 
		location: "Ubicación de prueba generada por seed #"+n.to_s, 
		institution_id: partner_aux.institution_id
	)
end
print("\n\tSeed:\tSolicitud de pruebas por socios creadas [20] \n")


print("\n\tSeed:\tCreando solicitudes con vinculadores: ")
request_count = Request.count
(1..10).step(1) do |n|
	vinculador_aux_id = rand(31..40)
	has_partner = rand(0..2)
	if has_partner == 0
		user_id = vinculador_aux_id
	else
		user_id = rand(16..25)
	end
	dueno = User.where(id:user_id).first
	institution_id = dueno.institution_id
	print(vinculador_aux_id.to_s+" ")
	vinculador_aux = User.where(id:vinculador_aux_id).first 	#Un socio al aazar
	actual_id = request_count+n
	Request.create(
		id: actual_id,
		user_id: user_id, 
		title: "Solicitud de prueba por VINCULADOR generada por seed #"+actual_id.to_s, 
		description: "Descripción de Solicitud de Servicio por VINCULADOR de prueba generada por seed #"+actual_id.to_s, 
		created_at: Time.now-rand*(20-40).days,
		start_time: Time.now-rand*(20).days, 
		end_time: Time.now+rand*(20).days, 
		resume: "Resumen de Solicitud prueba por VINCULADOR generada por seed #"+actual_id.to_s, 
		status: 1, 
		area_id: rand(1..42), 
		location: "Ubicación de Solicitud prueba por VINCULADOR generada por seed #"+actual_id.to_s, 
		institution_id: institution_id,
		broker_id: vinculador_aux.id
	)
end
print("\n\tSeed:\tSolicitud de servicio por vinculadores creadas [10] \n")

print("\n\tSeed:\tCreando servicios con profesores responsables: ")
(1..25).step(1) do |n|

	publication_type = rand(0..1) #0:request   #1:offering
	publication_id = rand(1..30)  #Cualquier publicacion

	if publication_type == 0 #BASADOS EN REQUEST
		professor_aux_id = rand(11..20)
		professor_aux = User.where(id: professor_aux_id).first 	#Un professor al azar
		publication_aux = Request.where(id: publication_id).first
		while (publication_aux.status != 1 or publication_aux.user.category==3)
			publication_id = rand(1..30)
			publication_aux = Request.where(id: publication_id).first
		end
		days = (professor_aux.confirmed_at.to_date..Time.now.to_date).count
		creation_date = professor_aux.confirmed_at+rand(days-25).days
		Service.create( 
			id: n, 
			publication_id: publication_id, 
			publication_type: "Request", 
			creator_id: professor_aux.id, #Creador de servicio, no de la solicitud
			acceptor_id: publication_aux.user_id, #Creador de la solicitud
			area_id: publication_aux.area.id, 
			institution_id: professor_aux.institution_id, #institucioon del profesor
			title: "Servicio basado en solicitud #"+publication_aux.id.to_s, 
			status: 4,
			message: "Mensaje de prueba de servicio #"+n.to_s, 
			description: "Descripción de del Servicio basado en Solicitud de prueba por seed #"+publication_aux.id.to_s,
			resume: "Resumen de prueba del Servicio generado basado en Solicitud por seed #"+publication_aux.id.to_s, 
			created_at: creation_date,
			start_time: creation_date+5.days, 
			end_time: creation_date+rand(5..15).days, 
			learning_objectives: "Objetivos de Aprendizaje del Servicio basado en solicitud #"+n.to_s, 
			service_objectives: "Objetivos de Servicio del Servicio basado en solicitud #"+n.to_s,
			broker_id: publication_aux.broker_id
		)
		print("R"+publication_id.to_s+" ")
	else #BASADOS EN OFFERING
		partner_aux_id = rand(21..30)
		partner_aux = User.where(id: partner_aux_id).first		#Un socio al azar
		publication_aux = Offering.where(id: publication_id).first
		while publication_aux.user.category == 3 or publication_aux.status != 1
			publication_id = rand(1..30)
			publication_aux = Offering.where(id: publication_id).first
		end
		days = (publication_aux.user.confirmed_at.to_date..Time.now.to_date).count
		creation_date = publication_aux.user.confirmed_at+rand(days-25).days
		Service.create( 
			id: n, 
			publication_id: publication_aux.id, 
			publication_type: "Offering", 
			creator_id: partner_aux.id, #Creador del servicio, no de la oferta
			acceptor_id: publication_aux.user_id, #Creador de la oferta
			area_id: publication_aux.area.id, 
			institution_id: publication_aux.institution_id, #intitucion del profesor
			title: "Servicio basado en la Oferta #"+publication_aux.id.to_s, 
			status: 4,
			message: "Mensaje de prueba de servicio #"+n.to_s, 
			description: "Descripción de del Servicio basado en Oferta de prueba por seed #"+publication_aux.id.to_s,
			resume: "Resumen de prueba del Servicio generado basado en Oferta por seed #"+publication_aux.id.to_s, 
			created_at: creation_date,
			start_time: creation_date+5.days, 
			end_time: creation_date+rand(5..15).days, 
			learning_objectives: "Objetivos de Aprendizaje del Servicio basado en oferta #"+n.to_s, 
			service_objectives: "Objetivos de Servicio del Servicio basado en oferta #"+n.to_s,
			broker_id: publication_aux.broker_id
		)
		print("O"+publication_id.to_s+" ")
	end
	publication_aux.status = 4 #Con esto la oferta o la soliitud pasa al estado de servicio
	publication_aux.created_at = creation_date-rand(10..15).days
	publication_aux.start_time =  creation_date-rand(5).days
	publication_aux.end_time = creation_date+(rand*(20+n)).days
	publication_aux.save
end
print("\tSeed:\tServicios de pruebas creadas basadas las ofertas y solicitudes de prueba [25] \n")


print("\n\tSeed:\tCreando Experiencias basados en los servicios: ")
(1..15).step(1) do |n| #ESTA CONDICION SE PUEDE CAMBIAR
	service_aux_id = rand(1..25)
	service_aux = Service.where(id:service_aux_id).first
	while service_aux.status == 5
		service_aux_id = rand(1..25)
		service_aux = Service.where(id:service_aux_id).first
	end
	print service_aux_id.to_s+" "
	
	professor_aux = User.where(id:service_aux.creator_id).first
	if professor_aux.category == 2
		partner_aux = User.where(id: service_aux.acceptor_id).first
	else
		partner_aux = User.where(id:service_aux.creator_id).first
		professor_aux = User.where(id: service_aux.acceptor_id).first
	end
	Experience.create(
		id: n,
		description: "Descripción basada en servicio #"+service_aux.id.to_s,
		title: "Experiencia basada en servicio #"+service_aux.id.to_s,
		institution_id: service_aux.institution_id,
		faculty: "Facultad de prueba Experiencia basada en servicio #"+service_aux.id.to_s,
		department: "Departamento de prueba para Experiencia basada en servicio #"+service_aux.id.to_s,
		region: "Región de la experiencias #"+n.to_s,
		comuna: "Comuna de la experiencias #"+n.to_s,
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
		created_at: service_aux.end_time+rand(10).days,
		start_time:	service_aux.start_time,
		end_time: service_aux.end_time,
		professor_id: professor_aux.id,
		partner_id: partner_aux.id,
		broker_id: service_aux.broker_id,
	)
	if (Experience.last.created_at >= Time.now)
		last = Experience.last
		last.created_at = Time.now-1.days
		last.save
	end

	service_aux.status = 5 #Con esto el servicio pasa a estado de experiencia
	service_aux.save
end
print("\n\tSeed:\tExperiencias de pruebas creadas [15]\n")



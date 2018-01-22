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
	["profesor@rease.cl",'rease2017', 'profesor Prueba', 'profesor', 2, 1],
	["vinculador@rease.cl",'rease2017', 'Vinculador Prueba', 'Vinculador', 3, 1],
	["socio@rease.cl",'rease2017', 'Socio Prueba', 'Socio',4,1]
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
	[14,"#{Rails.root}/public/institution/usach.png", "Universidad de Santiago de Chile", "http://rsu.usach.cl/"],
	[15,"#{Rails.root}/public/institution/utem.png", "Universidad Técnica Metropolitana", "http://www.utem.cl/"]
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

User.create([{
	email: 'edmundo.leiva@usach.cl',
	password: 'rease2017',
	name: 'Edmundo Leiva Lobos',
	nickname: 'Profe Edmundo', 
	category: 2, 
	autorization_level: 1, 
	confirmed_at: Time.now,
}])

print("\n\tSeed:\tAsignado usuarios básicos cargos dentro de la usach")
	profesor = User.where(id:2).first
	socio = User.where(id:3).first
	vinculador = User.where(id:4).first
	profesor.institution_id = 14
	socio.institution_id = 14
	vinculador.institution_id=14
	usach = Institution.where(id:14).first
	utem = Institution.where(id:15).first
	edmundo = User.last
	edmundo.institution = usach
	profesor.institution = utem
	usach.manager_id = edmundo.id
	utem.manager_id = profesor.id
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
	profesor.save
	edmundo.save
	socio.save
	vinculador.save
print("\n\tSeed:\tUsarios básicos asignados a usach:")

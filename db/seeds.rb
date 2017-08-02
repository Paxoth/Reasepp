# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create([{
	email: 'coordinacion.rease@gmail.com',
	password: 'rease2015',
	name: 'Coordinación',
	last_name: 'REASE',
	nickname: 'Usuario1', 
	category: 1, 
	autorization_level: 1, 
	confirmed_at: Time.now
}])

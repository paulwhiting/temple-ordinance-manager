# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Ordinance.destroy_all
#ActiveRecord::Base.connection.execute('TRUNCATE ordinances RESTART IDENTITY')
ActiveRecord::Base.connection.execute('UPDATE SQLITE_SEQUENCE SET SEQ=0 WHERE NAME="ordinances"')
Ordinance.create!( name: 'Baptism', url: 'http://lds.org/Baptism', code: 'B' )
Ordinance.create!( name: 'Confirmation', url: 'http://lds.org/Confirmation', code: 'C' )
Ordinance.create!( name: 'Initiatory', url: 'http://lds.org/Initiatory', code: 'I' )
Ordinance.create!( name: 'Endowment', url: 'http://lds.org/Endowment', code: 'E' )
Ordinance.create!( name: 'SealingChildToParents', url: 'http://lds.org/SealingChildToParents', code: 'SP' )
Ordinance.create!( name: 'SealingToSpouse', url: 'http://lds.org/SealingToSpouse', code: 'SS' )
puts "Created #{Ordinance.count} ordinances"

Status.destroy_all
#ActiveRecord::Base.connection.execute('TRUNCATE statuses RESTART IDENTITY')
ActiveRecord::Base.connection.execute('UPDATE SQLITE_SEQUENCE SET SEQ=0 WHERE NAME="statuses"')
Status.create!( name: 'Ready', url: 'http://familysearch.org/v1/Ready' )
Status.create!( name: 'NotReady', url: 'http://familysearch.org/v1/NotReady' )
Status.create!( name: 'Reserved', url: 'http://familysearch.org/v1/Reserved' )
Status.create!( name: 'Submittable', url: 'http://familysearch.org/v1/Submittable' )
Status.create!( name: 'NeedMoreInformation', url: 'http://familysearch.org/v1/NeedMoreInformation' )
Status.create!( name: 'NotAvailable', url: 'http://familysearch.org/v1/NotAvailable' )
Status.create!( name: 'Completed', url: 'http://familysearch.org/v1/Completed' )
Status.create!( name: 'NotNeeded', url: 'http://familysearch.org/v1/NotNeeded' )
Status.create!( name: 'NotNeededBornInCovenant', url: 'http://familysearch.org/v1/NotNeededBornInCovenant' )
Status.create!( name: 'InProgress', url: 'http://familysearch.org/v1/InProgress' )
Status.create!( name: 'Resubmittable', url: 'http://familysearch.org/v1/Resubmittable' )
Status.create!( name: 'NeedPermission', url: 'http://familysearch.org/v1/NeedPermission' )
Status.create!( name: 'Cancelled', url: 'http://familysearch.org/v1/Cancelled' )
Status.create!( name: 'Deleted', url: 'http://familysearch.org/v1/Deleted' )
Status.create!( name: 'Invalid', url: 'http://familysearch.org/v1/Invalid' )
puts "Created #{Status.count} status values"


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'pp'
mongo_client = Mongoid::Clients.default


Photo.mongo_client.database.fs.find.each { |photo|
  photo_id = photo[:_id].to_s
  p = Photo.find(photo_id)
  p.destroy
}


mongo_client[:places].delete_many()


mongo_client[:places].indexes.create_one(
  {'geometry.geolocation': Mongo::Index::GEO2DSPHERE}
)


place_file = File.open("./db/places.json")
Place.load_all(place_file)


Dir.glob("./db/image*.jpg").each { |file_name| 
  p = Photo.new 
  f = File.open(file_name)
  f.rewind
  p.contents = f 
  id = p.save
}  


Photo.all.each { |photo|
  place_id = photo.find_nearest_place_id(1609.34)
  photo_id = photo.id.to_s
  p = Photo.find(photo_id)
  p.place = place_id
  p.save
}
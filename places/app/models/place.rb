class Place
  include Mongoid::Document
  include ActiveModel::Model
 
  require 'mongo'
  require 'pp'
  require 'byebug'
  require 'uri'
  require 'json'

 @@db = nil
 
 def self.mongo_client
    @@db = Mongo::Client.new('mongodb://localhost:27017/places_development')
 end

def self.collection
    self.mongo_client if not @@db
    @@db[:places]
end

def self.load_all io
	file_json = JSON.parse(io.read)
	self.collection.insert_many(file_json)
end	


end

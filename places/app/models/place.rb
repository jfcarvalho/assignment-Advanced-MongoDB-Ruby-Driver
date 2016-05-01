class Place
  include Mongoid::Document
  include ActiveModel::Model
 
  require 'mongo'
  require 'pp'
  require 'byebug'
  require 'uri'
  require 'json'

  attr_accessor :id, :formatted_address, :location, :address_components

 @@db = nil

 def initialize(params={})
    @id = params[:_id].to_s

    @address_components = []
    if !params[:address_components].nil?
      address_components = params[:address_components]
      address_components.each { |a| @address_components << AddressComponent.new(a) }
    end
    

    @formatted_address = params[:formatted_address]
    @location = Point.new(params[:geometry][:geolocation])
  end

 
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

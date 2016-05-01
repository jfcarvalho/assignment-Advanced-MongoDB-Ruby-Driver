class Point
	require 'mongo'
  	require 'pp'
  	require 'byebug'
  	require 'uri'
  	require 'json'

	attr_accessor :longitude, :latitude

	def self.to_hash
		{"type":"Point", "coordinates"=>[@longitude, @latitude]} #GeoJSON Point format
		
	end

	def initialize(params={})
		 if params[:type]
      @longitude = params[:coordinates][0]
      @latitude = params[:coordinates][1]
    else
      @longitude = params[:lng]
      @latitude = params[:lat]	
  	end
       end

       def to_hash
    {:type=>"Point",:coordinates=>[@longitude, @latitude]}
  end
end	

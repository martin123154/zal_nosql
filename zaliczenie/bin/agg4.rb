#!/usr/bin/ruby

require 'mongo'
require 'builder'
require 'optparse'
require_relative '../lib/connection'

conn = Connection.new
db = conn.client.database
alarms = conn.alarms

dist="SS"

results = alarms.aggregate([
    {"$match" => { district: dist}},
    {"$limit" => 10}
    ])

geojson = Array.new
results.each do |result|
  temp=result[:location].split(",")
  longitude=temp[0].tr("(","")
  latitude=temp[1].tr(")","")
  geojson << {
  type: 'Feature',
  geometry: {
    type: 'Point',
    coordinates: [Float(longitude), Float(latitude)]
  },
  properties: {
    name: result[:incidentLocation]
  }
}
end

puts geojson

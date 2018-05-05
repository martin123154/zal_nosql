#!/usr/bin/ruby

require 'mongo'
require 'builder'
require 'optparse'
require_relative '../lib/connection'
require 'squid'
require 'prawn'


conn = Connection.new
db = conn.client.database
alarms = conn.alarms


results = alarms.aggregate([
  {'$group' => { _id: {district: "$district"}, 'count' => { '$sum' => 1}}},
  {'$sort' => {count: -1}}
  ])
arr=[]
for i in 0..results.to_a.size()-1
  arr << results.to_a[i][:_id][:district]
  arr << Integer(results.to_a[i][:count])
end
h=Hash[*arr]

  Prawn::Document.generate("district_alarms.pdf") do
    data = {alarms: h}
    chart data
  end

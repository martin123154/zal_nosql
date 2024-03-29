#!/usr/bin/ruby

require 'mongo'
require 'builder'
require 'optparse'
require_relative '../lib/connection'
require 'squid'
require 'prawn'


conn = Connection.new
db = conn.client.database
baza = conn.baza


results = baza.aggregate([
  {'$group' => { _id: {license: "$License Type"}, 'count' => { '$sum' => 1}}},
  {'$sort' => {count: -1}}
  ])
arr=[]
for i in 0..results.to_a.size()-1
  arr << results.to_a[i][:_id][:license]
  arr << Integer(results.to_a[i][:count])
end
h=Hash[*arr]

  Prawn::Document.generate("license_type.pdf") do
    data = {baza: h}
    chart data
  end

#!/usr/bin/ruby

require 'mongo'
require 'builder'
require 'optparse'
require_relative '../lib/connection'

options = {}
optparse = OptionParser.new do |opt|
  opt.on('-d', '--license type symbol') { |o| options[:License Type] = o }
end

begin
  optparse.parse!
rescue OptionParser::MissingArgument
  puts "\nUse -d <symbol> to select a district statistc.\n"
end

if options[:License Type]
    license=options[:License Type]
else
  license="Standard License"
end

conn = Connection.new
db = conn.client.database
baza = conn.baza

results = baza.aggregate([
    {"$match" => { License Type: license}},
    {'$group' => { '_id' => '$Endorsement Type', 'count' => { '$sum' => 1}}},
    {'$sort' => {count: -1}},
    ])


puts results.to_a

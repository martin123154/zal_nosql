#!/usr/bin/ruby

require 'mongo'
require_relative '../lib/connection'

conn = Connection.new
db = conn.client.database
alarms = conn.alarms

# prompt user for inputs
puts "\nReady to input a new alarm document.\n"
puts "First, the required fields.\n\n"

puts "Call Date Time:\n"

# strip newline character from input with chomp
callDateTime = gets.chomp

puts "\nPriority\n"

priority = gets.chomp

puts "\nDistrict:"

district = gets.chomp


puts "\nShort description:\n"

description = gets.chomp

puts "\nCall phone number:\n"

callNumber = gets.chomp

puts "\nIncident location:\n"

incidentLocation = gets.chomp

puts "\nLocation coordinates (longitude, latitude):\n"

location = gets.chomp


# create a document for insertion
insert_doc = { 'callDateTime' => callDateTime,
               'priority' => priority,
               'district' => district,
               'description' => description,
               'callNumber' => callNumber,
               'incidentLocation' => incidentLocation,
               'location' => location
             }

# use the insert_one method on the restaurants collection
result = alarms.insert_one( insert_doc )

# check for success or failure
if result.n == 1
  puts "Document successfully created.\n#{insert_doc}"
else
  puts "Document creation failed."
end

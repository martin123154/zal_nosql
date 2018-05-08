#!/usr/bin/ruby

require 'mongo'
require_relative '../lib/connection'

conn = Connection.new
db = conn.client.database
alarms = conn.baza

# prompt user for inputs
puts "\nReady to input a new baza document.\n"
puts "First, the required fields.\n\n"

puts "Call Folder Number:\n"

# strip newline character from input with chomp
Folder Number = gets.chomp

puts "\nFirst Name\n"

First Name = gets.chomp

puts "\nLast Name:"

Last Name = gets.chomp


puts "\nPractitioner Status Type ID:\n"

Practitioner Status Type ID = gets.chomp

puts "\nPractitioner Status:\n"

Practitioner Status = gets.chomp

puts "\nLicense Type ID:\n"

License Type ID = gets.chomp

puts "\nLicense Original Issue Date\n"

License Original Issue Date = gets.chomp

puts "\nLicense Issue Date\n"

License Issue Date = gets.chomp


puts "\nLicense Expiration Date\n"

License Expiration Date = gets.chomp


puts "\n Endorsement Type ID \n"

Endorsement Type ID= gets.chomp


puts "\nEndorsement Type\n"

Endorsement Type = gets.chomp

puts "\nEndorsement Issue Date\n"

Endorsement Issue Date= gets.chomp




# create a document for insertion
insert_doc = { 'Folder Number' => Folder Number,
               'First Name' => First Name,
               'Last Name' => Last Name,
               'Practitioner Status Type ID' => Practitioner Status Type ID,
               'Practitioner Status' => Practitioner Status,
               'License Type ID' => License Type ID,
               'License Type' => License Type,
                'License Original Issue Date' => License Original Issue Date,
                 'License Issue Date' => License Issue Date,
                  'License Expiration Date' => License Expiration Date,
                   'Endorsement Type ID' => Endorsement Type ID,
                    'Endorsement Type' => Endorsement Type,
                    'Endorsement Issue Date' => Endorsement Issue Date,
             }

# use the insert_one method on the restaurants collection
result = baza.insert_one( insert_doc )

# check for success or failure
if result.n == 1
  puts "Document successfully created.\n#{insert_doc}"
else
  puts "Document creation failed."
end

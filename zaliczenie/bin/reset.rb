#!/usr/bin/ruby

require 'mongo'
require_relative '../lib/connection'

conn = Connection.new

conn.alarms.drop

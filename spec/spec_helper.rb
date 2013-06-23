require 'bundler/setup'
require 'simplecov'; SimpleCov.start

require 'minitest/spec'
require 'minitest/autorun'

require 'cql_model'

unless ENV['COVERAGE'] == 'no'
  require 'simplecov'
  SimpleCov.start do
    add_filter "/spec/"
  end
end

require 'support/setup_test_keyspace'

setup_cql_test

class Event < Cql::Model
  primary_key :id

  column :location, String
  column :date, Date
end

class Person < Cql::Model
  primary_key :id

  column :first_name, String
  column :last_name, String
  column :birth_date, Date, column_name: :dob
end

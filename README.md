# cql_model

cql_model provides an ActiveModel implementation on top of the cql-rb gem. It
is intended to provide the functionality needed to utilize Cassandra as an
ActiveModel compatible data store.

## Installation

Add this line to your application's Gemfile:

    gem 'cql_model'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cql_model

## Usage

    require 'cql_model'

    Cql::Base.establish_connection(host: '127.0.0.1')

    class Person < Cql::Model
      primary_key :id

      column :first_name, String
      column :last_name, String
      column :dob, Date
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

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

### Schema Definition

While Cassandra doesn't get super picky about schemas you should understand how
you're storing your data. To help with this you should define the primary key
and the columns you care about within your model.

#### Primary Key

Defining the primary key determines which column the id-oriented finders will
work with. The default primary key is `id`.

    primary_key :id
    primary_key 'card_number'

#### Columns

You define columns by supplying the attribute name, Ruby class for type
conversion and an optional set of options.

    column :first_name, String
    column :birth_date, Date
    column :birth_date, Date, column_name: :dob

The supported options for columns are as follows:

* `column_name`: actual column name for storing the attribute.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

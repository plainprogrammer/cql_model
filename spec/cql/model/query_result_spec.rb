require 'spec_helper'

describe Cql::Model::QueryResult do
  before :all do
    Cql::Base.establish_connection(host: '127.0.0.1')
    Cql::Base.connection.use('cql_model_test')
  end

  let(:empty_result) do
    query = 'SELECT * FROM events'
    result = Cql::Base.connection.execute(query)
    Cql::Model::QueryResult.new(result, Event)
  end

  let(:full_result) do
    query = 'SELECT * FROM people'
    result = Cql::Base.connection.execute(query)
    Cql::Model::QueryResult.new(result, Person)
  end

  describe '#empty?' do
    it { full_result.empty?.must_equal false }
    it { empty_result.must_be_empty }
  end
end

require 'spec_helper'

describe Cql::Base do
  describe '.establish_connection' do

  end

  describe '.connection' do
    before :all do
      Cql::Base.establish_connection(host: '127.0.0.1')
    end

    it { Cql::Base.connection.must_be_instance_of Cql::Client::SynchronousClient }
  end
end

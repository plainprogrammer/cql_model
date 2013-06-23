require 'spec_helper'

describe Cql::Model do
  before :all do
    Cql::Base.establish_connection(host: '127.0.0.1')
    Cql::Base.connection.use('cql_model_test')
  end

  describe 'Finders' do
    describe '#all' do
      it { Person.all.must_be_instance_of Cql::Model::QueryResult }
      it { Person.all.first.must_be_instance_of Person }
    end

    describe '#find(1)' do
      it { Person.find(1).must_be_instance_of Person }
    end

    describe "#find('1')" do
      it { Person.find('1').must_be_instance_of Person }
    end

    describe '#find(1,2)' do
      it { Person.find(1,2).must_be_instance_of Array }
      it { Person.find(1,2).size.must_equal 2 }
    end

    describe '#find([1])' do
      it { Person.find([1]).must_be_instance_of Array }
      it { Person.find([1]).size.must_equal 1 }
    end

    describe '#find([1,2])' do
      it { Person.find([1,2]).must_be_instance_of Array }
      it { Person.find([1,2]).size.must_equal 2 }
    end
  end
end

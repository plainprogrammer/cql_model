require 'spec_helper'

describe 'Cql::Model Finders' do
  before :all do
    Cql::Base.establish_connection(host: '127.0.0.1')
    Cql::Base.connection.use('cql_model_test')
  end

  describe '#all' do
    it { Person.all.must_be_instance_of Cql::Model::QueryResult }
    it { Person.all.first.must_be_instance_of Person }
  end

  describe '#find' do
    describe 'single records' do
      it { Person.find(1).must_be_instance_of Person }
      it { Person.find('1').must_be_instance_of Person }
    end

    describe 'multiple/array records' do
      it { Person.find(1,2).must_be_instance_of Array }
      it { Person.find(1,2).size.must_equal 2 }

      it { Person.find([1]).must_be_instance_of Array }
      it { Person.find([1]).size.must_equal 1 }

      it { Person.find([1,2]).must_be_instance_of Array }
      it { Person.find([1,2]).size.must_equal 2 }
    end
  end

  describe '#find_by' do
    it { Person.find_by(first_name: 'John').must_be_instance_of Array }
    it { Person.find_by(first_name: 'John').size.must_equal 1 }

    it { Person.find_by(first_name: 'John', last_name: 'Doe').must_be_instance_of Array }
    it { Person.find_by(first_name: 'John', last_name: 'Doe').size.must_equal 1 }
  end
end

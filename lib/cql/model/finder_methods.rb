module Cql::Model::FinderMethods
  extend ::ActiveSupport::Concern

  module ClassMethods
    def all
      query = "SELECT * FROM #{self.model_name.plural}"
      cql_results = Cql::Base.connection.execute(query)
      Cql::Model::QueryResult.new(cql_results, self)
    end

    def find(primary_key_value)
      query = "SELECT * FROM #{self.model_name.plural} WHERE #{self.primary_key} = #{primary_key_value}"
      cql_results = Cql::Base.connection.execute(query)
      Cql::Model::QueryResult.new(cql_results, self).first
    end
  end
end

module Cql::Model::PersistenceMethods
  extend ::ActiveSupport::Concern

  def save
    updates = Cql::Statement.clauses(attributes).join(', ')
    query = Cql::Statement.sanitize("UPDATE #{table_name} SET #{updates} WHERE #{primary_key} = ?", [primary_value])
    Cql::Base.connection.execute(query)

    @persisted = true
    self
  end

  def deleted?
    @deleted
  end

  def delete
    query = Cql::Statement.sanitize("DELETE FROM #{table_name} WHERE #{primary_key} = ?", [primary_value])
    Cql::Base.connection.execute(query)

    @deleted = true
    @persisted = false
    self
  end

  module ClassMethods

  end
end

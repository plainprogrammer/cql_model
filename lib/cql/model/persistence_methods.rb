module Cql::Model::PersistenceMethods
  extend ::ActiveSupport::Concern

  def save
    atts = attributes
    fields = atts.keys.join(', ')
    values = atts.values
    placeholders = ('?' * atts.count).chars.join(', ')
    query = Cql::Statement.sanitize("INSERT INTO #{table_name} (#{fields}) VALUES (#{placeholders})", values)
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

module Cql::Model::PersistenceMethods
  extend ::ActiveSupport::Concern

  def save
    updates = []

    self.class.columns.each do |key, config|
      value = instance_variable_get("@#{config[:attribute_name].to_s}".to_sym)
      value = "'#{value}'" unless value.is_a?(Fixnum)
      updates << "#{key.to_s} = #{value}" unless value.nil?
    end

    updates = updates.join(', ')

    query = "UPDATE #{table_name} SET #{updates} WHERE #{primary_key} = #{quoted_primary_value}"
    Cql::Base.connection.execute(query)

    @persisted = true
    self
  end

  module ClassMethods

  end
end

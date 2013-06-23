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

    table = self.class.model_name.plural
    primary_key = self.class.primary_key.to_s

    query = "UPDATE #{table} SET #{updates} WHERE #{primary_key} = #{quoted_primary_value}"
    Cql::Base.connection.execute(query)

    @persisted = true
    self
  end

  module ClassMethods

  end
end

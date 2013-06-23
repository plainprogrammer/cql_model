module Cql::Model::SchemaMethods
  extend ::ActiveSupport::Concern

  def table_name
    self.class.table_name
  end

  def primary_key
    self.class.primary_key
  end

  module ClassMethods
    def table_name
      @table_name ||= self.model_name.plural
    end

    def columns
      @columns ||= {}
    end

    def primary_key(key_name = nil)
      @primary_key ||= key_name.nil? ? 'id' : key_name.to_s
    end

    def column(attribute_name, ruby_class, options = {})
      column_name = options[:column_name] || attribute_name

      @columns ||= {}
      @columns[column_name.to_sym] = {
        attribute_name: attribute_name.to_sym,
        klass: ruby_class.to_s.constantize
      }.merge(options)
    end
  end
end

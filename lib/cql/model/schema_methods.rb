module Cql::Model::SchemaMethods
  extend ::ActiveSupport::Concern

  module ClassMethods
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

require 'active_model'

require 'active_support/concern'
require 'active_support/core_ext'

require 'cql/base'
require 'cql/model/version'
require 'cql/model/schema_methods'
require 'cql/model/finder_methods'
require 'cql/model/query_result'

module Cql
  class Model
    extend ActiveModel::Naming

    #include ActiveModel::AttributeMethods
    #include ActiveModel::Callbacks
    include ActiveModel::Conversion
    include ActiveModel::Dirty
    #include ActiveModel::Observing
    include ActiveModel::Serialization
    #include ActiveModel::Translation
    include ActiveModel::Validations

    include Cql::Model::SchemaMethods
    include Cql::Model::FinderMethods

    def initialize(attributes = {}, options = {})
      self.class.columns.each do |key, config|
        class_eval do
          attr_reader config[:attribute_name]
          attr_writer config[:attribute_name] unless config[:read_only]
        end
      end

      @metadata = options[:metadata]

      attributes.each do |key, value|
        attr_name = "@#{key.to_s}".to_sym
        instance_variable_set(attr_name, value)
      end

      self
    end
  end
end

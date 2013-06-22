require 'cql/model/version'
require 'cql/base'

require 'active_model'

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
  end
end

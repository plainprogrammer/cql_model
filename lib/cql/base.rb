require 'cql'

module Cql
  module Base
    def self.establish_connection(options = {})
      @@connection = Cql::Client.connect(options)
    end

    def self.connection
      @@connection
    end
  end
end

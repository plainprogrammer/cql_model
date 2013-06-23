module Cql::Model::FinderMethods
  extend ::ActiveSupport::Concern

  module ClassMethods
    def all
      query = "SELECT * FROM #{self.model_name.plural}"
      execute(query)
    end

    def find(*args)
      value = args.to_a.flatten.join(',')
      key = self.primary_key
      table = self.model_name.plural

      query = "SELECT * FROM #{table} WHERE #{key} IN (#{value})"

      if args[0].is_a?(Array) || args.size > 1
        execute(query).to_a
      else
        execute(query).first
      end
    end

    def find_by(hash)
      table = self.model_name.plural

      clause = "WHERE "
      clause_pieces = hash.collect {|key,value| "#{key.to_s} = '#{value}'"}
      clause << clause_pieces.join(' AND ')

      query = "SELECT * FROM #{table} #{clause} ALLOW FILTERING"

      execute(query).to_a
    end
  end
end

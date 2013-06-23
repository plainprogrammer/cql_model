module Cql::Model::FinderMethods
  extend ::ActiveSupport::Concern

  module ClassMethods
    def all
      query = "SELECT * FROM #{table_name}"
      execute(query)
    end

    def find(*args)
      value = args.to_a.flatten.join(',')

      query = "SELECT * FROM #{table_name} WHERE #{primary_key} IN (#{value})"

      if args[0].is_a?(Array) || args.size > 1
        execute(query).to_a
      else
        execute(query).first
      end
    end

    def find_by(hash)
      clause = "WHERE "
      clause_pieces = hash.collect {|key,value| "#{key.to_s} = '#{value}'"}
      clause << clause_pieces.join(' AND ')

      query = "SELECT * FROM #{table_name} #{clause} ALLOW FILTERING"

      execute(query).to_a
    end
  end
end

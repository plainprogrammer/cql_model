module Cql::Model::FinderMethods
  extend ::ActiveSupport::Concern

  module ClassMethods
    def all
      query = "SELECT * FROM #{table_name}"
      execute(query)
    end

    def find(*args)
      query = Cql::Statement.sanitize("SELECT * FROM #{table_name} WHERE #{primary_key} IN (?)", args.to_a.flatten)

      if args[0].is_a?(Array) || args.size > 1
        execute(query).to_a
      else
        execute(query).first
      end
    end

    def find_by(hash)
      clause = "WHERE "
      clause_pieces = hash.collect { |key| "#{key.to_s} = ?" }
      clause << clause_pieces.join(' AND ')

      query = Cql::Statement.sanitize("SELECT * FROM #{table_name} #{clause} ALLOW FILTERING", hash.values)
puts "executing [#{query}]"
      execute(query).to_a
    end
  end
end

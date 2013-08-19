module Cql::Model::FinderMethods
  extend ::ActiveSupport::Concern

  module ClassMethods
    def all
      query = "SELECT * FROM #{table_name}"
      execute(query)
    end

    def find(*args)
      values = args.to_a.flatten
      placeholders = ('?' * values.count).chars.join(', ')
      query = Cql::Statement.sanitize("SELECT * FROM #{table_name} WHERE #{primary_key} IN (#{placeholders})", values)

      if args[0].is_a?(Array) || args.size > 1
        execute(query).to_a
      else
        execute(query).first
      end
    end

    def find_by(hash)
      clauses = Cql::Statement.clauses(hash).join(' AND ')
      query = "SELECT * FROM #{table_name} WHERE #{clauses} ALLOW FILTERING"
      execute(query).to_a
    end
  end
end

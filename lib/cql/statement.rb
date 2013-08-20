module Cql
  class Statement

    module Error
      class InvalidBindVariable < Exception; end
      class UnescapableObject < Exception; end
    end

    def self.escape(obj)
      obj.gsub("'", "''")
    end

    def self.quote(obj)
      if obj.kind_of?(Array)
        obj.map { |member| quote(member) }.join(",")
      elsif obj.kind_of?(String)
        "'" + obj + "'"
      elsif obj.kind_of?(Numeric)
        obj.to_s
      elsif obj.kind_of?(Cql::Uuid)
        obj.to_s
      elsif obj.kind_of?(TrueClass) or obj.kind_of?(FalseClass)
        obj.to_s
      elsif obj.nil?
        obj.to_s
      else
        raise Error::UnescapableObject, "Unable to escape object of class #{obj.class}"
      end
    end

    def self.cast_to_cql(obj)
      if obj.kind_of?(Array)
        obj.map { |member| cast_to_cql(member) }
      elsif obj.kind_of?(Numeric)
        obj
      elsif obj.kind_of?(Date)
        obj.strftime('%Y-%m-%d')
      elsif obj.kind_of?(Time)
        (obj.to_f * 1000).to_i
      elsif obj.kind_of?(Cql::Uuid)
        obj
      elsif obj.kind_of?(TrueClass) or obj.kind_of?(FalseClass)
        obj
      else
        #RUBY_VERSION >= "1.9" ? escape(obj.to_s.dup.force_encoding('ASCII-8BIT')) : escape(obj.to_s.dup)
        escape(obj.to_s.dup)
      end
    end
  
    def self.sanitize(statement, bind_vars=[])
      # If there are no bind variables, return the statement unaltered
      return statement if bind_vars.empty?

      bind_vars = bind_vars.dup
      expected_bind_vars = statement.count("?")

      raise Error::InvalidBindVariable, "Wrong number of bound variables (statement expected #{expected_bind_vars}, was #{bind_vars.size})" if expected_bind_vars != bind_vars.size
    
      statement.gsub(/\?/) {
        quote(cast_to_cql(bind_vars.shift))
      }
    end
    
    def self.clauses(hash)
      result = []
      hash.each_pair { |key, value| result << "#{key} = #{quote(cast_to_cql(value))}" }
      result
    end
  end
end

class Cql::Model::QueryResult
  include Enumerable

  attr_reader :metadata

  def initialize(results, klass)
    @metadata = results.metadata
    @rows = results.collect {|result| klass.new(result, metadata: @metadata)}
  end

  def empty?
    @rows.nil? || @rows.empty?
  end

  def each(&block)
    @rows.each(&block)
  end
  alias_method :each_row, :each
end

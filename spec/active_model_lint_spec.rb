require 'spec_helper'
require 'active_model'

describe 'ActiveModel Lint' do
  include ActiveModel::Lint::Tests

  def setup
    @model = CQL::Model.new
  end
end

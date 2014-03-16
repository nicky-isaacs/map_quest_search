# encoding: utf-8
require "test/unit"

require_relative '../lib/mapquestsearch'

class TestMapQuestSearch < Test::Unit::TestCase

  def test_raw
    result = MapQuestSearch.raw('denver colorado usa', :json)
    assert !result.nil?
    assert(result.is_a? Array)
  end

end

# encoding: utf-8
require "test/unit"

require_relative '../lib/map_quest_search'

class TestMapQuestSearch < Test::Unit::TestCase
  def test_raw
    result = MapQuestSearch.raw('denver colorado usa', :json)
    assert( !result.is_a?(String) )
  end
end
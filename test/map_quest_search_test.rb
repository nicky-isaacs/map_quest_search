# encoding: utf-8
require "test/unit"

require_relative '../lib/map_quest_search'

class TestMapQuestSearch < Test::Unit::TestCase
  
  # def test_italian
#       assert_equal :italian, @wl.language("Roma, capitale dell'impero romano, è stata per secoli il centro politico e culturale della civiltà occidentale.")
#   end
  
  def test_raw
    result = MapQuestSearch.raw('denver colorado usa', 'json')
    assert(result.class == Hash)
  end
end
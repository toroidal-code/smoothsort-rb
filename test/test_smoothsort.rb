require 'minitest_helper'

class TestSmoothsort < MiniTest::Unit::TestCase
  def test_that_it_has_a_version_number
    refute_nil ::Smoothsort::VERSION
  end

  def test_numeric_sort
    a = (1..20).to_a.shuffle
    assert_equal a.sort, a.ssort
  end

  def test_string_sort
    a = ('a'..'z').to_a.shuffle
    assert_equal a.sort, a.ssort
  end

  def test_big_array
    a = (1..500000).to_a.shuffle
    assert_equal a.sort, a.ssort
  end
end

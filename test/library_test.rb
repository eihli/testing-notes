require 'minitest/autorun'
require_relative '../lib/library'

class LibraryTest < MiniTest::Test
  def test_library_init_attributes
    library = Library.new 'San Francisco Public Library'
    assert_equal library.name, 'San Francisco Public Library'
  end
end

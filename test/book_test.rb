require 'minitest/autorun'
require_relative '../lib/book'

class BookTest < MiniTest::Test
  def test_book_attributes
    book = Book.new 'The Wealth of Nations', 'Adam Smith'
    assert_equal book.title, 'The Wealth of Nations'
    assert_equal book.author, 'Adam Smith'
  end
end

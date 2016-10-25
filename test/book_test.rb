require 'minitest/autorun'
require_relative '../lib/book'

class BookTest < MiniTest::Test
  def test_book_attributes
    book = Book.new 'The Wealth of Nations', 'Adam Smith', 544
    assert_equal book.title, 'The Wealth of Nations'
    assert_equal book.author, 'Adam Smith'
    # page_count preferred over pages for clarity. Plurality implies iterable/list
    assert_equal book.page_count, 544
  end
end

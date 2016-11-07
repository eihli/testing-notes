require 'minitest/autorun'
require_relative '../lib/library'
require_relative '../lib/book'

class LibraryTest < MiniTest::Test
  def test_library_init_attributes
    library = Library.new 'San Francisco Public Library'
    assert_equal library.name, 'San Francisco Public Library'
  end

  def test_get_books_from_library
    library = Library.new 'San Francisco Public Library'
    assert_equal library.books, []
  end

  def test_add_book_to_library
    library = Library.new 'San Francisco Public Library'
    book = Book.new 'Wealth of Nations', 'Adam Smith', 544
    library.add book
    assert_equal library.books, [book]
  end

  # We want our library to have standards. We only want to allow
  # books with over 500 pages.
  # We can't really test this yet because our books don't have a
  # 'pages' attribute.
  def test_library_has_standards
    library = Library.new 'San Francisco Public Library'
    book = Book.new 'Cat in the Hat', 'Dr. Seuss', 61
    library.add book
    assert_equal library.books, []
  end
end

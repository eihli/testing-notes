class Book
  attr_reader :title, :author, :page_count

  # Because we change our Book's signature, any test that
  # uses 'books' will be broken, even though its code is probably
  # still fine.
  def initialize(title, author, page_count)
    @title = title
    @author = author
    @page_count = page_count
  end
end

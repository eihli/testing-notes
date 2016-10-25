class Library
  attr_reader :name, :books

  def initialize(name)
    @name = name
    @books = []
  end

  # Our tests fail, not because this code is wrong,
  # but because our book doesn't yet implement the #pages method
  def add(book)
    if book.pages >= 500
      @books << book
    end
  end
end

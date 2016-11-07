class Library
  attr_reader :name, :books

  def initialize(name, policy)
    @name = name
    @books = []
    @policy_checker = PolicyChecker.new policy
  end

  # Our tests fail, not because this code is wrong,
  # but because our book doesn't yet implement the #pages method
  def add(book)
    if policy_checker.conforms?(book)
      @books << book
    end
  end
end

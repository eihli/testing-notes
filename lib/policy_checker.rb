class PolicyChecker
  def initialize(policy)
    @policy = policy
  end

  def conforms?(book)
    book.page_count >= @policy.min_page_count
  end
end

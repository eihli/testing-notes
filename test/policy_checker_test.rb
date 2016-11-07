require 'minitest/autorun'
require_relative '../lib/policy_checker'
require_relative '../lib/policy'
require_relative '../lib/book'

class PolicyCheckerTest < MiniTest::Test
  def test_min_page_count_policy
    policy = Policy.new({
      min_page_count: 500
    })
    book = Book.new 'Wealth of Nations', 'Adam Smith', 544
    policy_checker = PolicyChecker.new policy
    assert_equal policy_checker.conforms?(book), true
    book = Book.new 'Cat in the Hat', 'Dr. Seuss', 61
    assert_equal policy_checker.conforms?(book), false
  end
end

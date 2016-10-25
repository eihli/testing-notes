require 'minitest/autorun'
require_relative '../lib/policy'

class PolicyTest < MiniTest::Test
  def test_min_page_count_policy
    policy = Policy.new({
      min_page_count: 500
    })
    assert_equal policy.min_page_count, 500
  end
end

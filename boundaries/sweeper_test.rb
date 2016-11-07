# Note:
# This logic could have been in the user on a method called
# `should_be_swept?`, but it is business logic that is not
# an intrinsic attribute of `User`
class Sweeper
  def self.sweep
    Uer.all.select do |user|
      user.active? && user.paid_at < 1.month.ago
    end.each do |user|
      UserMailer.billing_problem(user)
    end
  end
end

describe Sweeper do
  context "when a subscription is expired" do
    let(:bob) do
      stub(:active? => true,
          :paid_at => 2.months.ago)
    end
    let(:users) { [bob] }
    before { User.stub(:all) { users } }

    it "emails the user" do
      UserMailer.should_receive(:billing_problem).with(bob)
      Sweeper.sweep
    end
  end
end

# The Sweeper depends on User and Mailer but we've replaced them with Stubs and Mocks
# The world that it sees while the test is running is just the Stub and Mock.
#
# Good things that come from this
# - Test-Drive Design
#   - If your mocking out a dozen dependencies and some of them are mocked 3 levels deep, you have a huge design problem
# - It enables outside-in TDD
#   - You can write the Sweeper before the User or Mailer even exist
# - Extremely fast tests. You don't need a full Rails app just to run a couple small unit tests.
#
# Downside
# - You're running your tests against something different than production
#
# Fixing Doubles
#
# Contract & Collaboration
# - Write more tests to verify all the boundaries are correct
#
# Tools
# - Make sure anything you mock, the method must really exist on the object
#   - Prevents simple boundary mistakes
# - Static typing and static mocks
#   - Think of every mock as a subclass of the real class that just nulls out the implementation
#   - Raise a type error if you call the wrong method on the mock
#
# Write the Integration Tests
# - Problem: Integration Tests are a Scam
#

# Remove mocks and stubs but stay isolated
#
#
class Sweeper
  def self.sweep
    User.all.select do |user|
describe Sweeper do
  context "when a subscription is expired" do
    let(:bob) do
      User.new(:active? => true,
              :paid_at => 2.months.ago)
    end
    let(:users) { [bob] }

    it "emails the user" do
      ExpiredUsers.for_users(users).should == [bob]
    end
  end
end

class ExpiredUsers
  def self.for_users(users)
    users.select do |user|
      user.active? && user.paid_at < 1.month.ago
    end
  end
end

# The VALUE is the Boundary
# Instead of it destructively synchronously calling into the Database or the Mailer
#
#

# Notes

- If I deleted all of your code but let you keep your tests, could you reconstruct your code? [https://www.youtube.com/watch?v=XcT4yYu\_TTs](https://www.youtube.com/watch?v=XcT4yYu_TTs)

Example:

```
class NetsuiteCustomerFormatter
  include NetsuiteConcern

  def format(payload)
    {
      job_id: payload[:workspace_id],
      # How do you test this? How much setup is needed?
      assignee_id: interface.client.workspaces.customers[payload[:resource_id]]
    }
  end
end

describe NetsuiteCustomerFormatter do
  describe "#format" do
    it "returns a hash including the customer" do
      payload = {
        workspace_id: 5,
        resource_id: 10
      }

      expected = hash_including({customer: })
      expect(described_class.format(payload)).to eq(hash_including)
    end
  end
end

class NetsuiteCustomerFormatter
  include NetsuiteConcern

  def format(payload)
    {
      job_id: payload[:workspace_id],
      assignee_id: interface.get_assignee(payload[:workspace_id]).id
    }
  end
end

describe NetsuiteCustomerFormatter do
  describe "#format" do
    it "returns a hash with correct mappings" do
      payload = {
        workspace_id: 5,
        resource_id: 10
      }

      mock(described_class.interface).get_assignee.with(payload[:workspace_id]) { 11 }
      actual = described_class.format(payload)

      expected = {
        job_id: 5,
        resource_id: 11
      }

      expect(actual).to eq (expected)
    end
  end
end

class Interface
  def get_assignee(workspace_id)
    response = client.get("workspaces/#{workspace_id}", include: 'resource')
    response['resource']
  end
end

describe Interface do
  describe '#get_assignee' do
    it 'returns the resource' do
      VCR.use_cassette('workspace_include_resource') do
        response = described_class.get("workspaces/#{id}", include: 'resource')
        expect(response['resource']).to eq {id: '5'}
      end
    end
  end
end
```

## Benefits of functional programming

We've talked a lot about the benefits of functional programming.
Value taken in
Value given out
Easy to test
Easy to think about
No state to mess stuff up

But a world without state is a pretty useless world.
We need our programs to do something we can see.

Print to screen
Send an email
POST to an API

There goes all of the benefits of functional programming.

# Integration Tests Are A Scam

- TDD is primarily a design technique
- Finds design problems
  - If collaboration tests are hard to write, design is flawed
  - Your subjects are too coupled
  - Interactions too complicated
  - Need more abstractions
  - Interfaces too complicated
  - This forces better design
    - This forces fewer defects
      - Virtuous cycle

# Boundaries

## Test Doubles

## Scaling Tests

### Path Count

- If you have N conditionals in your branches, you have 2^N paths
- 500 conditionals in your program -> 150 digit number of paths

### Suite Runtime

- Every time you add test or code, it's in pairs
- Tests run linearly slower
- Code added slows down tests linearly also

## Values

`describe "+"`

- Nothing to isolate test from
- Easy to test in isolation
- Takes a value and returns a value
  - Not mutating anything
  - No dependencies

### Natural Isolation

- Value in -> Value out
- No dependencies

## Paradigms

### Procedural

- Yes Mutation
- Separate Data & Code

```ruby
def feeding_time
  walruses.each do |walrus|
    walrus.stomach << Cheese.new
  end
end
```

You know this is destructive. Each does not do anything if it is not destructive.
This is procedural. You know a walrus has a stomach. You know you can shovel things into the stomach.

### OO

- Yes Mutation
- Combined Data & Code

```ruby
def feeding_time
  walruses.each do |walrus|
    walrus.eat(Cheese.new)
  end
end

class Walrus
  def eat(food)
    @stomach << food
  end
end
```

Very similar to procedural but we hide the internals.

### Functional

- No Mutation
- Separate Data & Code

```ruby
def feeding_time
  walruses.map do |walrus|
    eat(walrus, "cheese")
  end
end

def eat(walrus, food)
  stomach = walrus.fetch(:stomach) + [food]
  walrus.merge(:stomach => stomach)
end
```

### Faux O

- No Mutation
- Combined Data & Code

```ruby
def feeding_time
  walruses.map do |walrus|
    walrus.eat(Cheese.new)
  end
end

class Walrus
  def eat
    Walrus.new(@name, @stomach + [food])
  end
end
```

Can't really build a system this way because it doesn't mutate. Can't touch a screen, can't touch a disk, etc...

## How to compose?

User DB - Expired Users - Mailer

```
class ExpiredUsers
  def self.for_users(users)
    users.select do |user|
      user.active? && user.paid_at < 1.month.ago
    end
  end
end

class Sweeper
  def self.sweep
    ExpiredUsers.for_users(User.all).each do |user|
      UserMailer.billing_problem(user)
    end
  end
end
```

Fundamental distictions

- ExpiredUsers makes all the decisions
- Sweeper contains all the dependencies

FunctionalCore

- Lots of paths
- Few to no dependencies
- Isolated

ImperativeShell

- Lots of dependencies
- Very few paths
- Integrated

Little functional pieces in the middle
Loop of imperative code that isolates them from the outside world/state

## Nice things that happen when you do this

### Concurrency - Actor model

```
queue = Queue.new
Thread.new { loop { queue.push(gets) } }
Thread.new { loop { puts(queue.pop) } }.join
```

Every value in your system is a possible message between the actors.

The Value is the Boundary

### Convert an inherently single threaded system to a system that is naturally parallel

This is easy to do because we have these values, like the `user` value, to push around a system.

```
def sweep
  expired_users(User.all).each do |user|
    notify_of_billing_problem(user)
  end
end
```

```
actor Sweeper
  User.all.each { |user| ExpiredUsers.push(user) }
  die
end
```

```
def expired_users(users)
  users.select do |user|
    user.active? && user.paid_at < 1.month.ago
  end
end
```

```
actor ExpiredUsers
  user = pop
  late = user.active? && user.paid_at < 1.month.ago
  BillingProblemNotification.push(user) if late
end
```

```
def notify_of_billing_problem(user)
  UserMailer.billing_problem(user)
end
```

```
actor BillingProblemNotification
  UserMailer.billing_problem(pop)
end
```

Values *afford* shifting boundaries.

#### Sweeper

##### User Value

#### Expired Users

##### User Value

#### Mailer

### Conclusion

- Easy Testing
- Fast tests
- No call boundary risks (You're not stubbing and mocking)
  - Your boundaries happen to be values, but you're using REAL values in your tests so you know that you're calling methods that actually exist.
- Concurrency gets easier
- Higher code mobility

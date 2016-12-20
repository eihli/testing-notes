# House

Objects

- House

Behavior

- Paint

```ruby
class Application
  def initialize
    @house = House.new
    @house.paint(Colors.RED)
  end
end

class House
  def initialize
    @paints = []
    @color = nil
    @garage = Garage.new(DEFAULT_PAINTS)
  end

  def paint(color)
    if @paints.empty?
      @paints << @garage.get_paint()
    @color = color
  end
end

def Garage
  def initialize
  end

  def get_paint
  end
end
```

```
describe House do
  describe 'paint' do
    it 'should alter color of house' do
      house = houses(:bob)
      house.paint(Colors.RED)
      expect(house.color).to eq Colors.RED
    end
  end

  # With Fixtures
  context 'when the house is out of paint' do
    it 'should get paint from the garage' do
      house = houses(:bob)
      expect(house.paints).to eq []
      expect(house.garage.paints).to eq[Paint.new(Colors.RED)]
      house.paint(Colors.RED)
      expect(house.garage.paints).to be_empty
      expect(house.color).to eq Colors.RED
    end
  end

  # Without Fixtures
  context 'when the house is out of paint' do
    it 'should get paint from the garage' do
      paint = Paint.new Colors.RED
      garage = Garage.new([paint])
      house = House.new(garage)
      house.paint(Colors.RED)
      expect(house.garage.paints).to be_empty
      expect(house.color).to eq Colors.RED
    end
  end
end
```

Fixtures simplify complex test setup.
Complex test setup

# Cars

House has one garage
House has many cars through garage
Breaks law of demeter
Would you say House has many wheels through cars through garage? Where do you draw the line?

Test house.paint and see the following error:
Undefined method inject on nil class.
I am trying to paint a house... what does this inject method mean?
Dig in and see that it is the fuel injector for a car.

Easily solved by updating fixtures or using a fixture that has a car with gas.

houses.yml
bobHouseWithCarWithGas:
garage: garageWithCarWithGas

garages.yml
garageWithCarWithGas:
car: carWithGas

cars.yml
carWithGas
gas: 5

The car is trying to go to the store because the house is out of paint.
I'm trying to paint a house to do so I have to understand the implementation of a car. I don't care about the implementation fo the car. I don't care that it is out of gas.

This is a "perfect" opportunity for a stub.
Stub the gas.get\_fuel method to return fuel, now we can inject and we can test that our house can be painted.

Later on we refactor to use electric vehicles. Now our specs are green but our code is broken. The inject method no longer exists.
That's probably why stubs get a bad name. But stubs aren't the problem. Coupling is the problem. Integration tests encouraged fixtures. Fixtures masked coupling.

What if we had a HousePainter object which took a house and an EmptyPaintHandler object? Then we can use any EmptyPaintHandler we want. We can use the house's car. We can call uber. We can order on Amazon. Our House and our PainterObject no longer need to know about how we get our paint. This makes testing easier, makes our code more robust and extensible.

If you were to fully integration test this house painting, think of how many tests you would need.

When the paint exists
When the paint doesn't exist
  When the house has a garage
    When the garage has a car
      When the car has gas
        When the store has paint
        When the store doesn't have paint
  When the house doesn't have a garage
    When the house has a phone
      When the phone has the Uber app
      When the phone is dead
        When the house has a charger

Since we can't fully integration test, we have to use our judgement to decide which tests are most important. Our judgement fails.

Imagine testing the HousePainter object in isolation.

The HousePainter knows about the House and about the EmptyPaintHandler.

We only have two paths
When the paint exists
When the paint doesn't exist
  When the EmtpyPaintHandler can get paint
  When the EmptyPainthandler cannot get paint

Granted, those conditionals have to go somewhere, but now those are reduced and it turns an multiplicative problem into a problem of addition.

StoreEmptyPaintHandler(car)
  When the car has gas
  Whent he car does not have gas

UberEmptyPaintHandler(phone)
  When the phone has a charge
  When the phone does not have a charge

Phone
When the phone is dead
  When the phone has a charger


#debugger

IF you are using a debugger to debug your code, that is a smell that you are doing something wrong.

If you are only writing a few lines at a time, no more than 10, and if you are testing as you go, you should know exactly where any 'bug' is.

But what if your code relies on some other object and THAT's where it's blowing up?

Then you aren't debugging. You are exploring the API (or worse, the implementation) of a dependency. If you have to explore the API of a dependency, that means it's doing something you don't expect. That means it must not have been documented very well. If it's a dependency that we control, and you don't understand it enough to know why it's blowing up, then that is a smell that that dependency needs to have better documentation or be refactored.

While the slides were pretty neat, I think we can all agree that this presentation would not be complete without Mister-E dropping some dope beats.

```
Stub and mocking
keeps code rocking
Dishing out
async non-blocking
code that keeps
M-link tick-tocking

Dependency's for third world nations
We write code for isolation.
Minimize test integration
With modular code formation

You won't have to search the call stack
For some unrelated callback
Having to @all in dev-chat
Just to get yourself back on track
To the small bug that you thought that
Was a single point in Piv-Track
Till you looked and then you saw that
It's dependencies were so fat
That you were soon forced to fallback
To a dozen lines that called Fact-
ory Girl fixtures and let that
stateful mess turn you to street crack

Don't you listen to the lies that those stateful fixture's told you
But reveal from their disguise and see they hide the truth from plain view
That your code complexity grew
It's time to once again do
Refactor what you once knew.

What you once knew, what you now know
Ain't the same both knowledge and code
both keep growing as we grow old
brains expand but code erodes

So head the words of Mister-E
and take it straight from the Swole-G
100% full certainty
Ditch those integration tests
And give both mocks and stubs respect

Peace
```

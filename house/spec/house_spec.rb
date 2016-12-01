describe House do
  describe '#paint' do
    context 'when the paint is available in the house' do
      before do
        expect(house.available_paints).to contain(color)
      end
      it 'paints the house'
    end
    context 'when the paint is not available in the house' do
      context 'when the paint is available at the store' do
        it 'paints the house'
      end
      context 'when the paint is not available at the store' do
        it 'does not paint the house'
      end
    end
  end
end

class House
  def paint(color)
    if !@availble_paints.contains(color)
      paint = get_paint_from_store(color)
      @available_paints.add(color)
    end
    @color = color
    remove_paint(@available_paints, color)
  end
end

class House
  def paint(color)
    if !@availble_paints.contains(color)
      paint = get_paint_from_store(color)
      @available_paints.add(color)
    end
    @color = color
    use_paint(@available_paints.get(color))
  end
end



describe House do
  describe '#paint' do
    context 'when the paint is available in the house' do
    context 'when the paint is not available in the house' do
      context 'when the house has a garage' do
        context 'when the garage has a car' do
          context 'when the car has gas' do
            context 'when the store has the color available' do
            end
            context 'when the store does not have the color avaialble' do
            end
          end
          context 'when the car does not have gas' do
          end
        end
        context 'when the garage does not have a car' do
        end
      end
      context 'when the house does not have a garage' do
      end
    end
  end
end

describe House do
  describe '#paint' do
    let(:user) { users(:alice) }
    let(:house) { alice.house }
    let(:color) { Colors.RED }

    context 'when the color is available' do
      before do
        # Nessary because fixtures might change
        expect(house.available_paints).to contain(color)
      end

      it 'paints the house' do
        expect(house.color).to_not eq color # Same
        house.paint(color)
        expect(house.color).to eq color
      end
    end

    context 'when the color is not available' do
      let(:store) { alice.store }

      before do

      end

      context 'when the paint is available at the store' do
        before do
          expect(store.available_paints).to contain(color)
        end

        it 'paints the house' do
          expect(house.color).to_not eq color
          house.paint(color)
          expect(house)
  end
end

describe House do
  describe '#paint' do
    context 'when the color is available' do
      # Without fixtures
      before do
        @house = House.new
        @color = Colors.RED
        expect(@house.available_paints).to contain(@color)
      end

      it 'paints the house' do
        expect(@house.color).to be_nil
        house.paint(@color)
        expect(@house.color).to eq @color
      end
    end

    context 'when the color is not available' do
    end
  end
end

describe House do
  describe '#paint' do
    context 'when the color is available' do
      # With fixtures
      before do
        @house = houses(:alice)
        @color = Colors.RED
        expect(@house.available_paints).to contain(@color)
      end

      it 'paints the house' do
        expect(@house.color).to be_nil
        house.paint(@color)
        expect(@house.color).to eq @color
      end
    end

    context 'when the color is not available' do
      before do
        @color = Colors.BLUE
        expect(@house.available_paints).to_not contain(@color)
      end

      context 'when the paint is at the store' do
        before do
          expect(Store.available_paints).to contain(@color)
        it 'paints the house' do
        end
      end
      context 'when the paint is not at the store' do
        it 'does not paint the house' do
        end
      end

      it 'does not paint the house' do
        house = House.new
        expect(house.color).to be_nil
        house.paint(Colors.RED)
        expect(house.color).to be_nil
      end
    end
  end
end

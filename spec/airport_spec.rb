require 'airport'
require 'plane'

## Note these are just some guidelines!
## Feel free to write more tests!!

# A plane currently in the airport can be requested to take off.
#
# No more planes can be added to the airport, if it's full.
# It is up to you how many planes can land in the airport
# and how that is implemented.
#
# If the airport is full then no planes can land

describe Airport do

  it 'Airport has a capacity' do
    expect(subject.capacity).to eql Airport::DEFAULT_CAPACITY
  end

  describe 'take off' do
    it 'instructs a plane to take off' do
      is_expected.to respond_to :instruct_to_take_off
    end

    it 'releases a plane' do
      plane = Plane.new
      plane.status = "landed"
      subject.hanger = [plane]
      subject.instruct_to_take_off plane
      expect(subject.hanger.include?(plane)).to be false
    end

    it 'changes status to flying' do
      plane = Plane.new
      plane.status = "landed"
      subject.hanger = [plane]
      subject.instruct_to_take_off plane
      expect(plane.status).to eql "flying"
    end

    it 'can only instruct planes within hanger to take off' do
      plane = Plane.new
      expect{subject.instruct_to_take_off(plane)}.to raise_error 'That plane is not in hanger'
    end

  end

  describe 'landing' do
    it 'instructs a plane to land' do
      (is_expected).to respond_to :instruct_to_land
    end

    it 'receives a plane' do
      plane = Plane.new
      subject.instruct_to_land plane
      expect(subject.hanger.include?(plane)).to be true
    end

    it 'can only land planes not in hanger' do
      plane = Plane.new
      subject.hanger << plane
      expect{subject.instruct_to_land(plane)}.to raise_error 'Plane already in hanger'
    end
  end

  describe 'traffic control' do
    context 'when airport is full' do
      it 'does not allow a plane to land' do
        plane = Plane.new
        subject.capacity.times {subject.hanger << :plane}
        expect{subject.instruct_to_land(plane)}.to raise_error 'Airport is full'
      end
    end

    # Include a weather condition.
    # The weather must be random and only have two states "sunny" or "stormy".
    # Try and take off a plane, but if the weather is stormy,
    # the plane can not take off and must remain in the airport.
    #
    # This will require stubbing to stop the random return of the weather.
    # If the airport has a weather condition of stormy,
    # the plane can not land, and must not be in the airport

    context 'when weather conditions are stormy' do
      xit 'does not allow a plane to take off'

      xit 'does not allow a plane to land'
    end
  end
end

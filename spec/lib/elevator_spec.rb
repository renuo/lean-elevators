require 'elevator'

RSpec.describe Elevator do
  let(:decider) { double(:empty_decider) }
  subject { described_class.new(decider) }

  describe '#new' do
    it 'assigns public data' do
      expect(subject.floor_number).to be_an(Integer)
      expect(subject.capacity).to be_an(Integer)
      expect(subject.people).to be_an(Enumerable)
      expect(subject.statistics).to be_an(Integer)
    end
  end

  describe '#full?' do
    it 'returns false if elevator is empty' do
      subject.people = Array.new
      expect(subject.full?).to be_falsey
    end

    it 'returns false if elevator contains 1 person' do
      subject.people = Array.new(1, double(:person))
      expect(subject.full?).to be_falsey
    end

    it 'returns true if capacity is reached' do
      subject.people = Array.new(subject.capacity, double(:person))
      expect(subject.full?).to be_truthy
    end

    # TODO: is it necessary to assure that this cannot happen?
    it 'returns true if capacity is overreached' do
      subject.people = Array.new(subject.capacity + 1, double(:person))
      expect(subject.full?).to be_truthy
    end
  end
end

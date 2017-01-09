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

    # TODO: should we expect an exception instead?
    it 'returns true if capacity is overreached' do
      subject.people = Array.new(subject.capacity + 1, double(:person))
      expect(subject.full?).to be_truthy
    end
  end

  describe '#move!' do
    let(:panels) { [double(:panel), double(:panel), double(:panel)] }

    it 'calls a decider to examine target floor' do
      expect(decider).to receive(:calculate_level).with(subject, panels)
      subject.move!(panels)
    end

    it 'moves elevator to floor number 5' do
      allow(decider).to receive(:calculate_level).and_return(5)
      subject.move!(panels)
      expect(subject.floor_number).to eq(5)
    end
  end

  describe '#load' do
    it 'adds persons to the elevator' do
      person = double(:person)
      expect(subject.people).not_to include(person)
      subject.load(person)
      expect(subject.people).to include(person)
    end
  end

  describe '#unload' do

  end
end

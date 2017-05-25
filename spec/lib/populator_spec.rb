require 'populator'

RSpec.describe Populator do
  let(:origin_floor) { double(people: [], press_up!: nil, press_down!: nil) }
  let(:target_floor) { double(people: [], press_up!: nil, press_down!: nil) }
  let(:floors) { [origin_floor, target_floor] }
  subject { described_class.new(floors) }

  describe '#new' do
    it 'initializes' do
      expect(subject).not_to be_nil
    end
  end

  describe '#populate' do
    before(:each) do
      allow(floors).to receive(:sample).with(2).and_return([origin_floor, target_floor])
    end

    it 'adds waiting people to floors' do
      expect { subject.populate }.to change { origin_floor.people.count }.by(3)
    end

    it 'lets people go up' do
      expect(origin_floor).to receive(:press_up!).exactly(3).times
      subject.populate
    end
  end
end

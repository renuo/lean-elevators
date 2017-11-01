module LeanElevators
  RSpec.describe Populator do
    let(:origin_floor) { instance_double(Floor, people: [], panel: Panel.new) }
    let(:target_floor) { instance_double(Floor, people: [], panel: Panel.new) }
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
    end
  end
end
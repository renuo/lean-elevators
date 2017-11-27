module LeanElevators
  RSpec.describe Populator do
    let(:origin_floor) { instance_double(Floor, people: [], panel: Panel.new) }
    let(:target_floor) { instance_double(Floor, people: [], panel: Panel.new) }
    let(:other_floor) { instance_double(Floor, people: [], panel: Panel.new) }
    let(:floors) { [origin_floor, other_floor, other_floor, other_floor, target_floor] }
    subject { described_class.new(floors) }

    describe '#new' do
      it { is_expected.not_to be_nil }
    end

    describe '#populate' do
      before(:each) do
        allow(floors).to receive(:sample).with(2).and_return([origin_floor, target_floor])
      end

      it 'adds waiting people to floors' do
        def waiting_people_sum(floors)
          floors.map { |floor| floor.people.count }.sum
        end

        expect { subject.populate }.to change { waiting_people_sum(floors) }.by(2)
        expect { subject.populate }.to change { waiting_people_sum(floors) }.by(3)
        expect { subject.populate }.to change { waiting_people_sum(floors) }.by(4)
        expect { subject.populate }.to change { waiting_people_sum(floors) }.by(5)
        expect { subject.populate }.to change { waiting_people_sum(floors) }.by(6)
        expect { subject.populate }.to change { waiting_people_sum(floors) }.by(7)
        expect { subject.populate }.to change { waiting_people_sum(floors) }.by(3)
        expect { subject.populate }.to change { waiting_people_sum(floors) }.by(1)
        expect { subject.populate }.to change { waiting_people_sum(floors) }.by(0)
      end
    end
  end
end

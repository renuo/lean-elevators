module LeanElevators
  RSpec.describe Building do
    let(:building_size) { 10 }
    let(:elevator) { instance_double('Elevator', floor_number: 0, full?: false, people: []) }
    subject { described_class.new(building_size, [elevator]) }

    describe '#new' do
      it 'initializes' do
        expect(subject).not_to be_nil
      end
    end

    describe '#tick' do
      it 'moves elevators' do
        expect(elevator).to receive(:move!).and_return(0)
        expect(elevator).to receive(:unload)
        expect(elevator).to receive(:load)
        subject.floors[0].people << instance_double('Person')
        subject.tick
      end
    end

    describe '#to_s' do
      it 'delivers an initial image' do
        expect(subject.to_s).not_to include('웃')
        expect(subject.to_s.split("\n")[0]).to include('[0]')
      end

      it 'repositions elevator' do
        allow(elevator).to receive(:floor_number).and_return(1)
        expect(subject.to_s.split("\n")[1]).to include('[0]')
      end

      it 'draws waiting people' do
        subject.floors[0].people << instance_double('Person')
        expect(subject.to_s.split("\n")[0]).to include('웃')
      end
    end
  end
end

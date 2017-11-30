module LeanElevators
  RSpec.describe Floor do
    subject { described_class.new }

    describe '#new' do
      it 'initializes a panel and a person container' do
        expect(subject.panel).not_to be_nil
        expect(subject.people).to be_an(Array)
      end
    end

    describe '#people_waiting?' do
      it 'signalizes waiting people' do
        expect(subject.people_waiting?).to be_falsey
        subject.people << instance_double('Person')
        expect(subject.people_waiting?).to be_truthy
      end
    end

    context 'moving people' do
      let(:person) { instance_double('Person') }
      let(:elevator) { instance_double('Elevator', full?: false) }
      let(:full_elevator) { instance_double('Elevator', full?: true) }

      describe '#load_elevator' do
        it 'transfers people to elevator' do
          expect(elevator).to receive(:load).with(person).twice
          subject.people = [person, person]
          subject.load_elevator(elevator)
        end

        it 'doesnt transfer people which dont exist' do
          expect(elevator).not_to receive(:load)
          subject.people = []
          subject.load_elevator(elevator)
        end

        it 'doesnt fill full elevator' do
          expect(full_elevator).not_to receive(:load)
          subject.people = [person, person]
          subject.load_elevator(full_elevator)
        end

        it 'resets the panel' do
          subject.panel.up!
          subject.panel.down!
          allow(elevator).to receive(:load)
          subject.load_elevator(elevator)
          expect(subject.panel.up?).to be_falsey
          expect(subject.panel.down?).to be_falsey
        end
      end

      describe '#unload_elevator' do
        it 'removes all people from elevator' do
          expect(elevator).to receive(:unload)
          subject.unload_elevator(elevator)
        end
      end
    end
  end
end

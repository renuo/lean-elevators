module LeanElevators
  RSpec.describe Elevator do
    let(:decider) { double(:empty_decider, calculate_level: 1) }
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
        subject.people = []
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
      let(:decider_dto) { double(:decider_dto) }

      before(:each) do
        allow(subject).to receive(:decider_dto).and_return(decider_dto)
      end

      it 'calls a decider to examine target floor' do
        expect(decider).to receive(:calculate_level).with(decider_dto)
        subject.move!(panels)
      end

      it 'moves elevator to floor number 5' do
        allow(decider).to receive(:calculate_level).with(decider_dto).and_return(2)
        subject.move!(panels)
        expect(subject.floor_number).to eq(2)
      end

      context 'when errors happen' do
        it 'doesnt move if floor number isnt present' do
          allow(decider).to receive(:calculate_level).with(decider_dto).and_return(5)
          expect { subject.move!(panels) }.to change { subject.errors.count }.by(1)
        end

        it 'catches and logs timeouts' do
          allow(Timeout).to receive(:timeout).and_raise(Timeout::Error)
          expect { subject.move!(panels) }.to change { subject.errors.count }.by(1)
        end

        it 'catches and logs timeouts' do
          allow(decider).to receive(:calculate_level).with(decider_dto).and_raise(Deciders::Net::LevelCalculationException)
          expect { subject.move!(panels) }.to change { subject.errors.count }.by(1)
        end
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
      let(:debarking_person) { double(:person, target_floor_number: 42) }
      let(:patient_person) { double(:person, target_floor_number: 1337) }

      before(:each) do
        subject.floor_number = 42
        subject.people = [patient_person, debarking_person, patient_person, debarking_person, patient_person]
      end

      it 'removes two persons who want to exit from elevator' do
        subject.unload
        expect(subject.people).to contain_exactly(patient_person, patient_person, patient_person)
      end

      context '(statistics)' do
        it 'counts unloaded people as being transported' do
          expect { subject.unload }.to change { subject.statistics }.from(0).to(2)
        end
      end
    end
  end
end

module LeanElevators
  RSpec.describe LoadingQueue do
    def elevator_double(load)
      instance_double(Elevator, "[#{load}]", people: [*1..load])
    end

    describe '#elevators_by_space' do
      subject { described_class.new(elevators).elevators_by_space }

      context 'when already sorted' do
        let(:elevators) { [*1..5].map { |i| elevator_double(i) } }
        it { is_expected.to eq(elevators) }
      end

      context 'when floors are different' do
        let(:elevators) { [*5..1].map { |i| elevator_double(i) } }
        it { is_expected.to eq(elevators.reverse) }
      end
    end
  end
end

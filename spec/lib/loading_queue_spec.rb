module LeanElevators
  RSpec.describe LoadingQueue do
    def elevator_double(floor_number, load)
      instance_double(Elevator, "#{floor_number}, #{load}", floor_number: floor_number, people: [*1..load])
    end

    describe '#elevators' do
      subject { described_class.new(elevators).elevators }

      context 'when already sorted' do
        let(:elevators) { [*1..5].map { |i| elevator_double(i, i) } }
        it { is_expected.to eq(elevators) }
      end

      context 'when floors are different' do
        let(:elevators) { [*5..1].map { |i| elevator_double(i, 0) } }
        it { is_expected.to eq(elevators.reverse) }
      end

      context 'when load is different' do
        let(:elevators) { [*5..1].map { |i| elevator_double(0, i) } }
        it { is_expected.to eq(elevators.reverse) }
      end

      context 'when floor and load is different' do
        let(:elevators) { [[3, 3], [3, 2], [3, 0], [2, 5], [2, 0]].map { |i, j| elevator_double(i, j) } }
        it { is_expected.to eq(elevators.reverse) }
      end
    end
  end
end


require 'decider_dto'
require 'elevator'
require 'floor'

RSpec.describe DeciderDto do
  describe '#new' do
    let(:instance) { DeciderDto.new(elevator, panels) }
    let(:elevator) { Elevator.new(double(:empty_decider)) }
    let(:panels) { [Panel.new] }

    context 'for elevator' do
      subject { instance.elevator }

      it 'builds transfer object' do
        expect(subject[:capacity]).to be_a(Numeric)
        expect(subject[:current_floor]).to be_a(Numeric)
        expect(subject[:target_floors]).to be_an(Enumerable)
        expect(subject[:statistics]).to be_a(Numeric)
      end
    end

    context 'for floors' do
      subject { instance.floors }

      it 'builds transfer object for floors' do
        expect(subject).to be_an(Enumerable)
        expect(subject.first[:panel][:up]).to be(false)
        expect(subject.first[:panel][:down]).to be(false)
      end
    end

    context 'when serializing to hash' do
      subject { instance.to_hash }

      it { is_expected.to be_a(Hash) }
    end
  end
end

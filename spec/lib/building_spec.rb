require 'building'

RSpec.describe Building do
  let(:elevator) { instance_double('Elevator', floor_number: 0, full?: false) }
  subject { described_class.new([elevator]) }

  describe '#new' do
    it 'initializes building' do
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
end

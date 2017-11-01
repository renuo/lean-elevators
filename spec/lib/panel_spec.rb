module LeanElevators
  RSpec.describe Panel do
    subject { described_class.new }

    it 'initializes with no buttons pressed' do
      expect(subject.up?).to be_falsey
      expect(subject.down?).to be_falsey
    end

    it 'can press the buttons' do
      expect { subject.up! }.to change { subject.up? }.from(false).to(true)
      expect { subject.down! }.to change { subject.down? }.from(false).to(true)
    end
  end
end
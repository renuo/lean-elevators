require 'person'

RSpec.describe Person do
  subject { described_class.new(3) }

  it 'can be initialized with target floor' do
    expect(subject.target_floor_number).to be(3)
  end
end

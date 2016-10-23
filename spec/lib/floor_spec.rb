require 'floor'

RSpec.describe Floor do
  subject { described_class.new }

  it 'initializes a panel and a person container' do
    expect(subject.panel).not_to be_nil
    expect(subject.persons).to be_an(Array)
  end

  it 'signalizes waiting people' do
    expect(subject.people_waiting?).to be_falsey
    subject.persons << double(:person)
    expect(subject.people_waiting?).to be_truthy
  end
end

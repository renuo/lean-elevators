require 'socket'
require 'deciders/net'

RSpec.describe Deciders::Net do
  describe '#initialize' do
    it 'opens a TCP connection' do
      server = TCPServer.new(3001)

      client = nil
      Thread.start { client = server.accept }.join(0.01)
      Thread.start { Deciders::Net.new }.join(0.01)

      sleep(0.001)
      expect(client).to be_an_instance_of(TCPSocket)
    end
  end

  describe '#calculate_level' do
    let(:instance) { described_class.new }
    let(:subject) { instance.calculate_level(double(to_json: '{}')) }
    let(:response) { double(body: '5') }
    let(:http_connection) { double(request: response) }

    before(:each) do
      allow_any_instance_of(::Net::HTTP).to receive(:start).and_return(http_connection)
    end

    it 'returns a level number by asking the network' do
      expect(http_connection).to receive(:request)
      expect(subject).to eq(5)
    end
  end
end

require 'socket'

module LeanElevators
  module LeanElevators
RSpec.describe Deciders::Net do
    describe '#initialize' do
      it 'opens a TCP connection' do
        server = TCPServer.new(1337)
        client = nil

        Thread.start { client = server.accept }.join(0.01)
        Thread.start { described_class.new('http://127.0.0.1:1337') }.join(0.01)

        sleep(0.001)
        expect(client).to be_an_instance_of(TCPSocket)
      end
    end

    describe '#calculate_level' do
      let(:instance) { described_class.new('https://example.com') }
      let(:subject) { instance.calculate_level(instance_double(DeciderDto, to_hash: {})) }
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

end


end
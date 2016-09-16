require 'rspec'
require 'wordpress_client/connection'

describe WordpressClient::Connection do
  let(:faraday) {double Faraday}
  let(:response) {instance_double Faraday::Response}
  let(:configuration) {double 'Configuration', endpoint: 'ENDPOINT'}
  before do
    allow(Faraday).to receive(:new).and_return(faraday)
  end
  let(:connection) {WordpressClient::Connection.new(configuration)}

  it 'should respond to get' do
    allow(faraday).to receive(:get).with('url', {}).and_return(response)
    expect(connection.get('url', {})).to eq(response)
  end
  it 'should respond to post' do
    allow(faraday).to receive(:post).with('url', {}).and_return(response)
    expect(connection.post('url', {})).to eq(response)
  end
  it 'should respond to delete' do
    allow(faraday).to receive(:delete).with('url', {}).and_return(response)
    expect(connection.delete('url', {})).to eq(response)
  end
end
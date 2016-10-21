require 'rspec'
require 'wordpress_client/client'
require 'wordpress_client/connection'

describe WordpressClient::Client do

  it 'should create a post' do
    connection = instance_spy WordpressClient::Connection
    client = WordpressClient::Client.new(connection)
    client.create_post title: 'title', content: 'content'
    expect(connection).to have_received(:post).with('posts', title: 'title', content: 'content')
  end
end
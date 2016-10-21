module WordpressClient
  class Client
    def initialize(connection)
      @connection = connection
    end

    def create_post(post)
      @connection.post('posts', post)
    end
  end
end
require 'faraday'
require 'faraday_middleware'
require 'faraday-http-cache'

module WordpressClient
  class Connection
    def initialize(configuration)
      @configuration = configuration
      @connection = Faraday.new(url: configuration.endpoint) do |faraday|
        if configuration.oauth_credentials
          faraday.use FaradayMiddleware::OAuth, configuration.oauth_credentials
        end

        if configuration.basic_auth
          faraday.basic_auth(configuration.basic_auth[:username], configuration.basic_auth[:password])
        end

        if configuration.debug
          faraday.response :logger
          faraday.use :instrumentation
        end

        if configuration.cache
          faraday.use :http_cache, store: configuration.cache, shared_cache: false
        end

        if configuration.proxy
          faraday.proxy configuration.proxy
        end

        faraday.use Faraday::Response::RaiseError
        faraday.response :json, :content_type => /\bjson$/
      end
    end

    [:get, :post, :delete].each do |method|
      define_method(method) do |url, params={}|
        @connection.send(method, url, params)
      end
    end
  end
end
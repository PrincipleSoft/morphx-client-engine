class Unite::Api::V1::Base

  class_attribute :api_url
  class_attribute :auth_type

  self.auth_type = :organization

  class << self

    def connection
      Unite::Api::V1::Connection.new(self.auth_type)
    end

    def request(type, *args)
      self.connection.execute(type, *args)
    end

    def index(params = {})
      request(:get, self.api_url, params)
    end

    def show(id, params = {})
      id ||= 0
      request(:get, self.api_url + "/#{id}", params)
    end

    def create(params = {})
      request(:post, self.api_url, params.to_json)
    end

    def update(id, params = {})
      id ||= 0
      request(:put, self.api_url + "/#{id}", params.to_json)
    end

    def destroy(id, params = {})
      id ||= 0
      request(:delete, self.api_url + "/#{id}")
    end
  end
end
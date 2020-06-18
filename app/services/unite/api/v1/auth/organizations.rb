class Unite::Api::V1::Auth::Organizations < Unite::Api::V1::Base

  self.api_url = "/api/v1/auth/organizations"
  self.auth_type = :public

  class << self
    # Unite::Api::V1::Auth::Organizations.create_token({secret_key: 'abcdef', secret_token: 'abcdef'})
    def create(params = {})
      request(:post, self.api_url, params.to_json)
    end
  end
end
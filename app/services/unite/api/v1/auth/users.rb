class Unite::Api::V1::Auth::Users < Unite::Api::V1::Base

  self.api_url = "/api/v1/auth/users"
  self.auth_type = :public

  class << self
    # Unite::Api::V1::Auth::Users.create_token(email: 'user1@example.com', password: 'abcdef')
    # Unite::Api::V1::Auth::Users.create_token({email: 'user1@example.com'}, { 'Authorization': 'eyJhbGciOiJIUzI1NiJ9.eyJ0eXBlIjoib3JnYW5pemF0aW9uIiwiaWQiOjcsImV4cCI6MTU5MDgzNjI0OX0.AovdOM-bx4r9iDr-6SOpoVXUTaaFqxoy6oajIUgn0ak'} )
    def create(params = {}, headers = {})
      request(:post, self.api_url, params.to_json, headers)
    end
  end
end
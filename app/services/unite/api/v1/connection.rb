module Unite
  module Api
    module V1
      class Connection
        include Unite::Api::HttpStatusCodes
        include Unite::Api::ApiExceptions

        API_DOMAIN = Rails.application.credentials[:unite][:client_site].freeze
        CLIENT_ID = Rails.application.credentials[:unite][:client_id].freeze
        CLIENT_SECRET = Rails.application.credentials[:unite][:client_secret].freeze

        def initialize(auth_type)
          @access_token = define_access_token(auth_type)
        end

        def execute(type, *args)
          p '-'*100
          p "Unite::Api --------------------------> #{type} #{args}"
          p '-'*100

          @response = client.public_send(type, *args)
          parsed_response = Oj.load(@response.body)

          return parsed_response if response_successful?

          raise error_class, "Code: #{@response.status}, response: #{@response.body}"
        end

        # private

        def client
          @_client ||= Faraday.new(API_DOMAIN) do |client|
            client.request :url_encoded
            client.adapter Faraday.default_adapter
            client.headers['Authorization'] = @access_token if @access_token.present?
            client.headers['Accept'] = "application/json"
            client.headers['Content-Type'] = "application/json"
          end
        end

        def define_access_token(auth_type)
          case auth_type
          when :organization
            access_token = Unite::AccessToken.last
            (access_token && !access_token.expired?) ? access_token.token : authorize!.token
          # when :user
          else nil
          end
        end

        def authorize!
          response = Unite::Api::V1::Auth::Organizations.create({secret_key: CLIENT_ID, secret_token: CLIENT_SECRET})
          Unite::AccessToken.create(token: response['response']['jwt_token'], exp_time: response['response']['exp_time'])
        end

        def error_class
          case @response.status
          when HTTP_BAD_REQUEST_CODE
            BadRequestError
          when HTTP_UNAUTHORIZED_CODE
            UnauthorizedError
          when HTTP_FORBIDDEN_CODE
            ForbiddenError
          when HTTP_NOT_FOUND_CODE
            NotFoundError
          when HTTP_UNPROCESSABLE_ENTITY_CODE
            UnprocessableEntityError
          else
            ApiError
          end
        end

        def response_successful?
          @response.status == HTTP_OK_CODE
        end
      end
    end
  end
end
module Unite::Concerns::Channel::Bridge
  extend ActiveSupport::Concern

  module ClassMethods
    def request_all(params = {})
      Unite::Api::V1::Organization::Channels.index(params)
    end
  end

  def request_show
    Unite::Api::V1::Organization::Channels.show(self.unite_id)
  end

  private

  def request_create
    api_response = Unite::Api::V1::Organization::Channels.create(channel_params)
    self.unite_id = api_response['response']['id']
  end

  def request_update
    Unite::Api::V1::Organization::Channels.update(self.unite_id, channel_params)
  end

  def request_destroy
    Unite::Api::V1::Organization::Channels.destroy(self.unite_id)
  end

  def channel_params
    self.attributes.slice("title", "description")
  end
end


# {"status" => 200, "response" => {"id" => 48,
#                                  "organization_id" => 7,
#                                  "status" => "approved",
#                                  "title" => "bla12",
#                                  "description" => "Description",
#                                  "shares_count" => 0,
#                                  "created_at" => "2020-06-23T07:52:52.927-05:00",
#                                  "updated_at" => "2020-06-23T07:52:52.927-05:00"}}
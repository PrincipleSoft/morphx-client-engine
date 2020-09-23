module Unite::Concerns::User::Bridge
  extend ActiveSupport::Concern

  module ClassMethods
    def request_all(params = {})
      Unite::Api::V1::Organization::Users.index(params)
    end
  end

  def request_show
    Unite::Api::V1::Organization::Users.show(self.unite_id)
  end

  private

  def request_create
    api_response = Unite::Api::V1::Organization::Users.create(user_params)
    self.unite_id = api_response['response']['id']
    # TODO presenter
    # TODO stream_accounts
  end

  def request_update
    Unite::Api::V1::Organization::Users.update(self.unite_id, user_params)
  end

  def request_destroy
    Unite::Api::V1::Organization::Users.destroy(self.unite_id)
  end

  def user_params
    self.attributes.slice("first_name", "last_name", "email", "password", "birthdate", "gender").merge(organization_membership: {role: self.attributes['organization_role']})
  end
end


# {"status"=>200,
#  "response"=>
#      {"id"=>46,
#       "first_name"=>"Jack",
#       "email"=>"test@gmail.com",
#       "display_name"=>"Jack Sparrow",
#       "birthdate"=>"1992-11-06",
#       "remember_created_at"=>nil,
#       "sign_in_count"=>0,
#       "current_sign_in_at"=>nil,
#       "last_sign_in_at"=>nil,
#       "current_sign_in_ip"=>nil,
#       "last_sign_in_ip"=>nil,
#       "confirmed_at"=>nil,
#       "confirmation_sent_at"=>"2020-06-09T08:08:46.572-05:00",
#       "created_at"=>"2020-06-09T08:08:46.572-05:00",
#       "updated_at"=>"2020-06-09T08:08:46.730-05:00",
#       "gender"=>"male",
#       "deleted"=>false,
#       "invitation_created_at"=>nil,
#       "invitation_sent_at"=>nil,
#       "invitation_accepted_at"=>nil,
#       "invitation_limit"=>nil,
#       "invited_by_type"=>nil,
#       "invited_by_id"=>nil,
#       "last_name"=>"Sparrow",
#       "unconfirmed_email"=>nil,
#       "braintree_customer_id"=>nil,
#       "facebook_friends"=>nil,
#       "time_format"=>"12hour",
#       "manually_set_timezone"=>nil,
#       "can_use_debug_area"=>false,
#       "dropbox_token"=>nil,
#       "profit_margin_percent"=>70.0,
#       "public_display_name_source"=>"display_name",
#       "shares_count"=>0,
#       "referral_participant_fee_in_percent"=>5.0,
#       "slug"=>"jack-sparrow",
#       "priority_gettogether_fee"=>nil,
#       "can_create_gettogethers_with_max_duration"=>30,
#       "can_record_gettogethers"=>false,
#       "can_create_sessions_with_max_duration"=>180,
#       "can_create_free_private_sessions_without_permission"=>false,
#       "can_publish_n_free_sessions_without_admin_approval"=>0,
#       "overriden_minimum_live_session_cost"=>nil,
#       "welcome_new_user_email_is_sent"=>false,
#       "can_create_gettogethers_as_regular_user"=>false,
#       "currency"=>"USD",
#       "short_url"=>"https://my.immerss.com/s/IsawjK",
#       "try_live_available"=>true,
#       "fake"=>false,
#       "show_on_home"=>false,
#       "affiliate_signature"=>"4ec48813b7ca.46",
#       "custom_slug"=>false,
#       "referral_short_url"=>"https://my.immerss.com/s/gD4qNX",
#       "promo_start"=>nil,
#       "promo_end"=>nil,
#       "promo_weight"=>0,
#       "language"=>"en",
#       "can_use_barcode_area"=>false,
#       "wowza_transcode"=>false,
#       "stream_accounts"=>
#           [{"id"=>130,
#             "user_id"=>46,
#             "server"=>nil,
#             "port"=>"123123",
#             "stream_name"=>"testss",
#             "authentication"=>false,
#             "username"=>nil,
#             "password"=>nil,
#             "hls_url"=>"https://cds.c5r2q9u4.hwcdn.net/3/4540/rid4540_uid3_d237f666e19710e5dd58dea66bb14d31.mp4",
#             "stream_status"=>nil,
#             "stream_id"=>"blablb",
#             "sandbox"=>true,
#             "transcoder_type"=>"passthrough",
#             "name"=>nil,
#             "idle_timeout"=>1200,
#             "host_ip"=>"0.0.0.0",
#             "delivery_method"=>"push",
#             "current_service"=>"main",
#             "source_url"=>nil,
#             "created_at"=>"2020-05-14T14:47:32.292-05:00",
#             "updated_at"=>"2020-06-09T08:08:47.556-05:00"}],
#       "presenter"=>
#           {"id"=>33,
#            "user_id"=>46,
#            "created_at"=>"2020-06-09T08:08:46.719-05:00",
#            "updated_at"=>"2020-06-09T08:08:46.719-05:00",
#            "credit_line_amount"=>"100.0",
#            "featured"=>false,
#            "listed"=>true}}}
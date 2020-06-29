class Unite::StreamAccount

  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :user, class_name: 'Unite::User', optional: false

  field :server, type: String
  field :port, type: String
  field :stream_name, type: String
  field :authentication, type: String
  field :username, type: String
  field :password, type: String
  field :hls_url, type: String
  field :stream_status, type: String
  field :stream_id, type: String
  field :sandbox, type: Boolean
  field :transcoder_type, type: String
  field :name, type: String
  field :idle_timeout, type: String
  field :host_ip, type: String
  field :delivery_method, type: String
  field :current_service, type: String
  field :source_url, type: String

end

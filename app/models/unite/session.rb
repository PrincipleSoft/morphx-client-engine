class Unite::Session < Unite::BaseModel

  include Unite::Concerns::Session::Bridge

  belongs_to :user, class_name: 'Unite::User', foreign_key: 'user_id', optional: false # TODO rename live_user
  belongs_to :channel, class_name: 'Unite::Channel', foreign_key: 'channel_id', optional: false

  field :unite_id, type: Integer # 1

  # accessible params
  field :title, type: String #, default: "My first Organization channel"
  field :description, type: String #, default: "Description"
  field :record, type: Boolean #, default: true
  field :allow_chat, type: Boolean #, default: true
  field :duration, type: Integer #, default: 15
  field :autostart, type: Boolean #, default: true
  field :start_at, type: DateTime #, default: 1.minute.from_now  # + 15.minutes + rand(100..10000).minutes # "2020-06-26 03:28:51 +0300"
  field :pre_time, type: Integer, default: 0
  field :device_type, type: String, default: "studio_equipment"
  field :service_type, type: String, default: "rtmp"

  # other fields
  field :immersive_type, type: String
  field :cancelled_at, type: DateTime
  field :stopped_at, type: DateTime
  field :status, type: String
  field :donations_goal, type: String
  field :start_now, type: Boolean
  field :embed, type: Hash

  before_create :request_create
  # before_update :request_update
  # before_destroy :request_destroy

  def displayable_embed
    # TODO fix embed and remove gsubs
    res = self.allow_chat ? self.embed['video_additions_live_chat'].gsub!('/additions', '/additions?chat=true') : self.embed['video_live']
    res.gsub!('http://', 'https://')
    res.gsub!('srcdoc=\'\'', '')
    res
  end
end
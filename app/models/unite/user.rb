class Unite::User < Unite::BaseModel

  include Unite::Concerns::User::Bridge

  has_many :sessions, class_name: 'Unite::Session', dependent: :destroy
  # has_many :stream_accounts, class_name: 'Unite::StreamAccount', dependent: :destroy
  # has_many :videos, class_name: 'Unite::Video', dependent: :destroy

  field :unite_id, type: Integer # 1
  # accessible params
  field :email, type: String, default: "organiztaion-user1@unite.live" # user@email.com
  field :first_name, type: String, default: "APiTest" # Jack
  field :last_name, type: String, default: "User" # Sparrow
  field :password, type: String, default: "password" # password
  field :birthdate, type: Date, default: "01.01.1990" # 1992-11-06
  field :gender, type: String, default: "male" # male/female
  field :organization_role, type: String, default: "presenter" # presenter/manager/administrator

  before_create :request_create
  before_update :request_update
  before_destroy :request_destroy

  # def channel
  #   Unite::Channel.first
  # end
end

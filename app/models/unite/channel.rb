class Unite::Channel < Unite::BaseModel

  include Unite::Concerns::Channel::Bridge

  has_many :sessions, class_name: 'Unite::Session'
  # has_many :videos, class_name: 'Unite::Video'

  field :unite_id, type: Integer # 1
  # accessible params
  field :title, type: String, default: 'My first Organization channel'
  field :description, type: String, default: 'Description'

  field :status, type: String
  field :shares_count, type: Integer

  before_create :request_create
  before_update :request_update
  before_destroy :request_destroy

end
class Unite::AccessToken
  include Mongoid::Document

  field :token, type: String
  field :exp_time, type: String

  def expired?
    (Time.zone.now > Time.at(self.exp_time.to_i)) rescue false
  end

  def expired_in
    (Time.at(self.exp_time.to_i) - Time.zone.now).to_i
  end
end
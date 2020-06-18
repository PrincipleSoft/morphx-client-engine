require 'rails_helper'

module Unite
  RSpec.describe AccessToken, type: :model do
    it 'should create a access token' do
      create(:access_token)

      expect(Unite::AccessToken.count).to eq(1)
    end
  end
end
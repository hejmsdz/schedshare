require 'rails_helper'

RSpec.describe TokensController, type: :controller do
  let(:user) { create(:user) }

  describe '#create' do
    let(:action) { post :create, params: { user_id: user.id } }

    it 'returns a valid access token' do
      action
      token = Knock::AuthToken.new(token: json_response['jwt'])
      expect(token.entity_for(user.class)).to eq(user)
    end
  end
end

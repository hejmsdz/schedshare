require 'rails_helper'

RSpec.describe TokensController, type: :controller do
  let(:user) { create(:user) }

  describe '#create' do
    let(:deliveries) { ActionMailer::Base.deliveries }
    let(:action) { post :create, params: { user_id: user.id } }

    it 'sends the token by email to the user' do
      action

      expect(deliveries.length).to eq(1)
      expect(deliveries.first.to).to eq([user.email])

      token = Knock::AuthToken.new(token: deliveries.first.body.to_s.lines[5])
      expect(token.entity_for(user.class)).to eq(user)
    end
  end
end

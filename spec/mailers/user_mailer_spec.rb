require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  let(:user) { create(:user) }

  describe 'token' do
    let(:token) { Knock::AuthToken.new(payload: { sub: user.id }).token }
    let(:mail) { UserMailer.token(user, token) }

    it 'renders the headers' do
      expect(mail.to).to eq([user.email])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include(token)
    end
  end

end

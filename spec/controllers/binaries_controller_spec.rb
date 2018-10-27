require 'rails_helper'

RSpec.describe BinariesController, type: :controller do

  describe 'GET #index' do
    let(:action) { get :index }

    context 'without an auth token' do

      it 'returns http unauthorized' do
        action
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with a valid token' do
      before { authenticate(user) }

      let(:user) { create(:user) }

      it 'returns http success' do
        action
        expect(response).to have_http_status(:success)
      end
    end
  end
end

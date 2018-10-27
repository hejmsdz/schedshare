require 'rails_helper'

RSpec.describe BinariesController, type: :controller do
  let(:user) { create(:user) }

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

      it 'returns http success' do
        action
        expect(response).to have_http_status(:success)
      end

      context 'when there are binaries available' do
        before { matt_binary; alex_binary }

        let(:matt) { create(:user) }
        let(:alex) { create(:user) }
        let(:matt_binary) { create(:binary, user: matt) }
        let(:alex_binary) { create(:binary, user: alex) }

        let(:attributes) { %i(id user_id version) }
        let(:expected_response) do
          [ matt_binary, alex_binary ].map do |b|
            b.slice(*attributes).merge(created_at: b.created_at.as_json, updated_at: b.updated_at.as_json)
          end
        end

        it 'returns the binaries' do
          action
          expect(json_response).to eq expected_response
        end

        context 'when there is more than one binary per user' do
          before { new_alex_binary }

          let(:new_alex_binary) { create(:binary, user: alex) }

          it 'only shows the latest one' do
            action
            ids = json_response.map { |binary| binary['id'] }
            expect(ids).to contain_exactly(matt_binary.id, new_alex_binary.id)
          end
        end
      end
    end
  end

  describe '#create' do
    let(:params) { {} }
    let(:action) { post :create, params: params }

    context 'without an auth token' do
      it 'returns http unauthorized' do
        action
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'with a valid token' do
      before { authenticate(user) }

      let(:new_binary) { build(:binary) }
      let(:params) { { binary: { version: new_binary.version, file: new_binary.file } } }

      it 'returns http created' do
        action
        expect(response).to have_http_status(:created)
      end 

      it 'creates a binary' do
        expect { action }.to change(Binary, :count).by(1)
        
        binary = Binary.last

        expect(binary.version).to eq(params[:binary][:version])
        expect(binary.user).to eq(user)
        expect(binary.file).to be_attached
      end
    end
  end
end

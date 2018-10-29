require 'rails_helper'

RSpec.describe BinariesController, type: :controller do
  render_views

  let(:user) { create(:user) }

  describe 'GET #index' do
    let(:action) { get :index, format: :json }

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

      context 'when there is a binary available' do
        before { binary }

        let(:binary) { create(:binary, user: user) }

        it 'returns an array with item' do
          action
          expect(json_response).to be_an Array
          expect(json_response.length).to eq(1)
        end

        it 'contains information about the binary' do
          action
          hash = json_response.first
          expect(hash).to include binary.slice(:id, :version, :user_id)
          expect(hash['created_at']).to eq(binary.created_at.as_json)
          expect(hash['checksum']).to eq(binary.file.checksum)
          expect(get: hash['url']).to route_to(controller: 'active_storage/blobs',
                                               action: 'show',
                                               signed_id: binary.file.signed_id,
                                               filename: binary.file.filename)
        end

        context 'when there is more than one binary per user' do
          before { new_binary; more_binaries }

          let(:new_binary) { create(:binary, user: user) }
          let(:another_user) { create(:user) }
          let(:more_binaries) { create_list(:binary, 2, user: another_user) }

          it 'only shows the latest one for each user' do
            action
            ids = json_response.map { |binary| binary['id'] }
            expect(ids).to contain_exactly(new_binary.id, more_binaries.last.id)
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

require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { create(:user) }

  describe '#binaries' do
    let(:binaries) { create_list(:binary, 2, user: user) }

    it 'contains binaries linked to the user' do
      expect(user.binaries).to contain_exactly(*binaries)
    end
  end
end

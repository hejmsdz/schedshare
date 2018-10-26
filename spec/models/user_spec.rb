require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { create(:user) }

  it { is_expected.to be_valid }

  describe '#email' do
    it 'must be present' do
      user.email = nil
      expect(user).not_to be_valid
    end

    it 'must be a valid email' do
      user.email = 'whatever'
      expect(user).not_to be_valid
    end
  end

  describe '#binaries' do
    let(:binaries) { create_list(:binary, 2, user: user) }

    it 'contains binaries linked to the user' do
      expect(user.binaries).to contain_exactly(*binaries)
    end
  end
end

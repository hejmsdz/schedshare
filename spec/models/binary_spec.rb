require 'rails_helper'

RSpec.describe Binary, type: :model do
  subject(:binary) { create(:binary) }

  it { is_expected.to be_valid }

  describe '#url' do
    it 'must be present' do
      binary.url = nil
      expect(binary).not_to be_valid
    end

    it 'must be a valid url' do
      binary.url = 'whatever'
      expect(binary).not_to be_valid
    end

    it 'cannot be an unsecure http url' do
      binary.url = 'http://example.com/'
      expect(binary).not_to be_valid
    end
  end
end

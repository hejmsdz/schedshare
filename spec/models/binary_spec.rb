require 'rails_helper'

RSpec.describe Binary, type: :model do
  subject(:binary) { create(:binary) }

  it { is_expected.to be_valid }

  describe '#file' do
    it 'exists' do
      expect(binary.file).to be_kind_of ActiveStorage::Attached::One
    end
  end
end

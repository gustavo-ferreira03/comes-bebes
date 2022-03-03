require 'rails_helper'

RSpec.describe Wallet, type: :model do
  describe 'validations' do
    it 'should not have a negative balance' do
      expect(build(:wallet, balance: -1)).to be_invalid
    end
  end
  describe 'creation' do
    it 'should be invalid without a user' do
      expect(build(:wallet)).to be_invalid
    end
    it 'should be valid with a user' do
      expect(build(:wallet, :for_user)).to be_valid
    end
  end
end

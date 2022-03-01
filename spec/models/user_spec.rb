require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it 'should be invalid without a name' do
      expect(build(:user, name: nil)).to be_invalid
    end
    it 'should be invalid without an email' do
      expect(build(:user, email: nil)).to be_invalid
    end
    it 'should be invalid without a phone number' do
      expect(build(:user, phone: nil)).to be_invalid
    end
    it 'should be invalid without a birthdate' do
      expect(build(:user, birthdate: nil)).to be_invalid
    end
    it 'should be invalid without a user type' do
      expect(build(:user, user_type: nil)).to be_invalid
    end
    it 'should have a unique email' do
      create(:user, email: "gustavo.fer@gmail.com")
      expect(build(:user, email: "gustavo.fer@gmail.com")).to be_invalid
    end
  end
  describe 'creation' do
    it 'when user is valid' do
      expect(build(:user)).to be_valid
    end
    it 'when user is invalid' do
      expect(build(:user, email: nil)).to be_invalid
    end
  end
end

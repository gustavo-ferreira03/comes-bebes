require 'rails_helper'

RSpec.describe Address, type: :model do
  describe "validations" do
    it 'should be invalid without a street' do
      expect(build(:address, street:nil)).to be_invalid
    end
    it 'should be invalid without a street' do
      expect(build(:address, street:nil)).to be_invalid
    end
    it 'should be invalid without a street' do
      expect(build(:address, street:nil)).to be_invalid
    end
    it 'should be invalid without a street' do
      expect(build(:address, street:nil)).to be_invalid
    end
  end
  describe "creation" do
    it "when address is valid for user" do
      expect(build(:address, :for_user)).to be_valid
    end
    it "when address is valid for restaurant" do
      expect(address = build(:address, :for_restaurant)).to be_valid
    end
    it "when address is invalid without association" do
      expect(address = build(:address)).to be_invalid
    end
  end
end

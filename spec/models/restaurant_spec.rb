require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  describe 'validations' do
    it 'should be invalid without a name' do
      expect(build(:restaurant, name: nil)).to be_invalid
    end
    it 'should be invalid without a cnpj' do
      expect(build(:restaurant, cnpj: nil)).to be_invalid
    end
    it 'should be invalid without a restaurant type' do
      expect(build(:restaurant, restaurant_type: nil)).to be_invalid
    end
    it 'should have a formatted cnpj' do
      expect(build(:restaurant, cnpj: "djaods1234")).to be_invalid
    end
  end
  describe "creation" do
    it "when restaurant is valid for user" do
      expect(build(:restaurant, :for_user)).to be_valid
    end
    it "when restaurant is invalid without association" do
      expect(build(:restaurant)).to be_invalid
    end
  end
end

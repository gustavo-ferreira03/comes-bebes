require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe 'validations' do
    it 'should be invalid without a name' do
      expect(build(:dish, name: nil)).to be_invalid
    end
    it 'should be invalid without an description' do
      expect(build(:dish, description: nil)).to be_invalid
    end
    it 'should be invalid without a value' do
      expect(build(:dish, value: nil)).to be_invalid
    end
    it 'should be invalid without a serving' do
      expect(build(:dish, serving: nil)).to be_invalid
    end
    it 'should be invalid without a stock' do
      expect(build(:dish, stock: nil)).to be_invalid
    end
    it 'should have a positive value' do
      expect(build(:dish, value: -1)).to be_invalid
    end
    it 'should have a description within 10-200 characters' do
      expect(build(:dish, description: 0)).to be_invalid
    end
  end
  describe "creation" do
    it "when dish is valid for restaurant" do
      expect(dish = build(:dish, :for_restaurant)).to be_valid
    end
    it "when dish is invalid without association" do
      expect(dish = build(:dish)).to be_invalid
    end
  end
end

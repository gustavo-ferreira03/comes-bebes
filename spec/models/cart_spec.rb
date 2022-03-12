require 'rails_helper'

RSpec.describe Cart, type: :model do
  describe 'validations' do
    it 'should have a discount value inbetween 0 and 1' do
      expect(build(:cart, discount: 1.1)).to be_invalid
    end
    it 'should have a status' do
      expect(build(:cart, status: nil)).to be_invalid
    end
  end
  describe "creation" do
    it "when cart is valid for user" do
      expect(build(:cart, :for_user)).to be_valid
    end
    it "when cart is invalid without association" do
      expect(build(:cart)).to be_invalid
    end
  end
end

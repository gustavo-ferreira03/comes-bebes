require 'rails_helper'

RSpec.describe CartItem, type: :model do
  describe 'validations' do
    it 'should have a quantity value greater than or equal to 1' do
      expect(build(:cart_item, quantity: 0)).to be_invalid
    end
  end
  describe "creation" do
    it "when cart item is valid for cart and dish" do
      expect(build(:cart_item, :for_cart_and_dish)).to be_valid
    end
    it "when cart item is invalid without association" do
      expect(build(:cart_item)).to be_invalid
    end
  end
end

require 'rails_helper'

RSpec.describe Image, type: :model do
  describe 'validations' do
    it 'should have an image link' do
      expect(build(:image, image_link: nil)).to be_invalid
    end
  end
  describe "creation" do
    it "when image is valid for dish" do
      expect(build(:image, :for_dish)).to be_valid
    end
    it "when image is valid for restaurant" do
      expect(build(:image, :for_restaurant)).to be_valid
    end
  end
end

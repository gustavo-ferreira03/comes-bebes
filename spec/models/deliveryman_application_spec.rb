require 'rails_helper'

RSpec.describe DeliverymanApplication, type: :model do
  describe 'validations' do 
    it 'should have a formatted cnh' do
      expect(build(:deliveryman_application, cnh: "12312")).to be_invalid
    end
  end
end

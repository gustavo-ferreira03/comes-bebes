require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /index" do
    it 'returns a status message' do
      get('/users/')
      expect(response.status).to equal(200)
    end
  end
end

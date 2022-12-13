require 'rails_helper'

RSpec.describe "Newsletters", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/newsletters/create"
      expect(response).to have_http_status(:success)
    end
  end

end

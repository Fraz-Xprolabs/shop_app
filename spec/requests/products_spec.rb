require 'rails_helper'

RSpec.describe "Products", type: :request do
  let(:user) { create(:user) }
  let!(:product) { create(:product, user: user) }

  describe "GET /index" do
    it "returns success" do
      get products_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /create" do
    it "creates a new product" do
      expect {
        post products_path, params: { product: { name: "Test", price: 10, stock: 5, user_id: user.id } }
      }.to change(Product, :count).by(1)
    end
  end
end

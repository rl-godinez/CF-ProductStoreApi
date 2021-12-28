require 'rails_helper'

RSpec.describe V1::ProductsController, type: :controller do
  let(:user) { create(:owner) }
  let(:bearer) { create(:token, user: user) }
  let(:headers) { { Authorization: "Bearer #{bearer.token}" } }
  let(:product) {
    {
      name: Faker::Book.title,
      description: Faker::Lorem.sentence(word_count: 50),
      price: rand(1..100)
    }
  }

  context 'registro del producto correctamente' do
    before do
      request.headers.merge! headers
      post(:create, format: :json, params: { product: product } )
    end

    context 'response con status de created' do
      subject { response }
      it { is_expected.to have_http_status(:created) }
    end

    context 'response con estructura del producto correcta' do
      subject { payload_test }
      it { is_expected.to include(:name, :description, :price, :created_at, :updated_at, :store_id) }
    end
  end

  context 'fallo del registro del producto' do
    before do
      request.headers.merge! headers
      product[:name] = ""
      post(:create, format: :json, params: { product: product } )
    end

    context 'response con status de bad_request' do
      subject { response }
      it { is_expected.to have_http_status(:bad_request)}
    end

    context 'response con estructura de errors correcta' do
      subject { payload_test }
      it { is_expected.to include(:errors) }
    end
  end

  context 'registro del producto sin token' do
    before do
      post(:create, format: :json, params: { product: product } )
    end

    context 'response con status unauthorized' do
      subject { response }
      it { is_expected.to have_http_status(:unauthorized) }
    end
  end
end
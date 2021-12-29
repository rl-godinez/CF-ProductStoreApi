require 'rails_helper'

RSpec.describe V1::ProductsController, type: :controller do
  let(:user) { create(:owner) }
  let(:bearer) { create(:token, user: user) }
  let(:headers) { { Authorization: "Bearer #{bearer.token}" } }
  let(:product) { create(:product, store: user.store) }

  context 'producto actualizado correctamente' do
    before do
      request.headers.merge! headers
      put(:update, format: :json, params: { id: product.id, product: { name: "testing" }})
    end

    context 'response con status ok' do
      subject { response }
      it { is_expected.to have_http_status(:ok) }
    end

    context 'response con estructura del producto correcta' do
      subject { payload_test }
      it { is_expected.to include(:id, :name, :description, :price, :store_id, :created_at, :updated_at) }
    end
  end

  context 'el producto no se puede actualizar' do
    before do
      request.headers.merge! headers
      put(:update, format: :json, params: { id: product.id, product: { name: "" }})
    end

    context 'response con status de bad_request' do
      subject { response }
      it { is_expected.to have_http_status(:bad_request) }
    end

    context 'estructura de respuesta con errores correcta' do
      subject { payload_test }
      it { is_expected.to include(:errors) }
    end
  end

  context 'request sin token' do
    before do
      put(:update, format: :json, params: { id: product.id, product: { name: "test" }})
    end

    context 'response con status de unauthorized' do
      subject { response }
      it { is_expected.to have_http_status(:unauthorized) }
    end
  end
end
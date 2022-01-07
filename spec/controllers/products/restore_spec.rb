require 'rails_helper'

RSpec.describe V1::ProductsController, type: :controller do
  describe 'restauracion de un producto' do
    let(:user) { create(:owner) }
    let(:bearer) { create(:token, user: user) }
    let(:headers) { { Authorization: "Bearer #{bearer.token}" } }
    let(:product) { create(:product, store: user.store) }

    context 'producto restaurado satisfactoriamente' do
      before do
        product.destroy
        request.headers.merge! headers
        post(:restore, format: :json, params: { id: product.id })
      end

      context 'response con status ok' do
        subject { response }
        it { is_expected.to have_http_status(:ok) }
      end

      context 'response con estructura del producto correcta' do
        subject { payload_test }
        it { is_expected.to include(:id, :price, :name, :description, :created_at, :updated_at, :store_id) }
      end
    end

    context 'fallo de restauracion del prodcto' do
      context 'request sin los headers de authorization' do
        before do
          product.destroy
          post(:restore, format: :json, params: { id: product.id })
        end

        context 'respuesta con status de unauthorized' do
          subject { response }
          it { is_expected.to have_http_status(:unauthorized) }
        end
      end

      context 'request con producto no encontrado' do
        before do
          product.destroy
          request.headers.merge! headers
          post(:restore, format: :json, params: { id: 2 })
        end

        context 'respuesta con status notfound' do
          subject { response }
          it { is_expected.to have_http_status(:not_found) }
        end
      end
    end
  end
end
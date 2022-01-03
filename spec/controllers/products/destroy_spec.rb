require 'rails_helper'

RSpec.describe V1::ProductsController, type: :controller do
  describe 'eliminar un producto' do
    let(:user) { create(:owner) }
    let(:bearer) { create(:token, user: user) }
    let(:headers) { { Authorization: "Bearer #{bearer.token}"}}
    let(:product) { create(:product, store: user.store) }

    context 'eliminado satisfactoriamente' do
      before do
        request.headers.merge! headers
        delete(:destroy, format: :json, params: { id: product.id })
      end

      context 'response con status ok' do
        subject { response }

        it { is_expected.to have_http_status(:ok) }
      end
    end

    context 'eliminar un producto sin token' do
      before do
        delete(:destroy, format: :json, params: { id: product.id })
      end

      context 'response con status de unauthorized' do
        subject { response }

        it { is_expected.to have_http_status(:unauthorized) }
      end
    end
  end
end
require 'rails_helper'

RSpec.describe V1::ProductsController, tye: :controller do
  let(:user) { create(:owner) }
  let(:bearer) { create(:token, user: user) }
  let(:headers) { { Authorization: "Bearer #{bearer.token}" } }

  context 'listado de productos' do
    before do
      request.headers.merge! headers
      get(:index, format: :json)
    end

    context 'response con status ok' do
      subject { response }
      it { is_expected.to have_http_status(:ok) }
    end

    context 'response con estructura de productos correcta' do
      subject { payload_test }
      it { is_expected.to include(:products) }
    end
  end

  context 'request sin token' do
    before do
      get(:index, format: :json)
    end

    context 'response con status de unauthorized' do
      subject { response }
      it { is_expected.to have_http_status(:unauthorized) }
    end
  end
end
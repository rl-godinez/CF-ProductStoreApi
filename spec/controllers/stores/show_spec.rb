require 'rails_helper'

RSpec.describe V1::StoresController, type: :controller do
  let(:user) { create(:owner) }
  let(:bearer) { create(:token, user: user) }
  let(:headers) { { Authorization: "Bearer #{bearer.token}" } }
  let(:stores) { create_list(:store, 5)}

  describe 'consultar tienda por id' do
    before do
      request.headers.merge! headers
      get(:show, format: :json, params: { id: user.store.id })
    end

    context "cuando el status code es 200" do
      subject { response }
      it { is_expected.to have_http_status(:ok) }
    end

    context "estructura correcta del store" do
      subject { payload_test }
      it { is_expected.to include(:id, :name) }
    end
  end

  describe "no se puede consultar la tienda de otro usuario" do
    before do
      request.headers.merge! headers
      get(:show, format: :json, params: { id: rand(2..stores.size) })
    end

    context 'estatus de response no autorizado' do
      subject { response }
      it { is_expected.to have_http_status(:unauthorized) }
    end
  end

  describe "no se puede consultar sin token" do
    before do
      get(:show, format: :json, params: { id: 1 })
    end

    context 'estatus de response no autorizado' do
      subject { response }
      it { is_expected.to have_http_status(:unauthorized) }
    end
  end
end
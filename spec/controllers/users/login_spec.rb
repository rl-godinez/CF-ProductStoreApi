require 'rails_helper'

RSpec.describe V1::UsersController, type: :controller do
  describe 'inicio de sesion del usuario' do
    let(:user) { create(:owner, password: "123456") }

    context 'inicio de sesion correcto' do
      before do
        post(:login, format: :json, params: {
          user: {
            email: user.email,
            password: 123456
          }
        })
      end

      context 'estatus correcto OK' do
        subject { response }
        it { is_expected.to have_http_status(:ok) }
      end

      context 'respuesta de login correcta' do
        subject { payload_test }
        it { is_expected.to include(:id, :email, :age, :store) }
      end

      context 'respuesta de token correcta' do
        subject { payload_test[:token] }
        it { is_expected.to include(:id, :token, :expires_at) }
      end
    end

    context 'inicio de sesion erroneo' do
      before do
        post(:login, format: :json, params: { user: {
          email: user.email,
          password: 123321
        }})
      end

      context 'estatus correcto bad_request' do
        subject { response }
        it { is_expected.to have_http_status(:bad_request) }
      end

      context 'response incluye errors' do
        subject { payload_test }
        it { is_expected.to include(:errors)}
      end
    end
  end
end
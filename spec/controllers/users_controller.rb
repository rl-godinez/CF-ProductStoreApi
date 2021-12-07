require 'rails_helper'

RSpec.describe V1::UsersController, type: :controller do
  describe 'registro de usuarios' do
    let(:user) do
      { email: Faker::Internet.email,
        age: rand(18..100),
        password: Faker::Internet.password(min_length: 10, max_length: 20, mix_case: true) }
    end

    context 'usuario registrado correctamente' do
      before do
        post(:create, format: :json, params: { user: user })
      end

      context 'respuesta con status created' do
        subject { response }
        it { is_expected.to have_http_status(:created) }
      end

      context 'respuesta con valores correctos de user' do
        subject { payload_test }
        it { is_expected.to include(:id, :email, :age) }
      end
    end

    context 'usuario con errores en el registro' do
      let(:bad_user) { { email: 'email', password: 123456, age: 10 }}

      before do
        post(:create, format: :json, params: { user: bad_user })
      end

      context 'respuesta con status bad_request' do
        subject { response }
        it { is_expected.to have_http_status(:bad_request) }
      end

      context 'respuesta contiene el key de errores' do
        subject { payload_test }
        it { is_expected.to include(:errors) }
      end
    end
  end
end

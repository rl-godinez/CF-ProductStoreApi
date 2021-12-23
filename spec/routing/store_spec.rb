require 'rails_helper'

describe 'Rutas de resources store' do
  it 'obtener un store' do
    expect(get: '/v1/stores/1').to route_to(
      format: 'json',
      controller: 'v1/stores',
      action: 'show',
      id: '1'
    )
  end
end

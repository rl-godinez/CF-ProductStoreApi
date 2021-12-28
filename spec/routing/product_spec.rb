require 'rails_helper'

describe 'Rutas de resource products' do
  it 'ruta para crear un producto' do
    expect(post: 'v1/products').to route_to(
      format: 'json',
      controller: 'v1/products',
      action: 'create'
    )
  end
end
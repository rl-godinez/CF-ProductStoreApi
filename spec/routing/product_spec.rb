require 'rails_helper'

describe 'Rutas de resource products' do
  it 'ruta POST para crear un producto' do
    expect(post: 'v1/products').to route_to(
      format: 'json',
      controller: 'v1/products',
      action: 'create'
    )
  end

  it 'ruta PUT para actualizar un producto' do
    expect(put: 'v1/products/1').to route_to(
      format: 'json',
      controller: 'v1/products',
      action: 'update',
      id: '1'
    )
  end

  it 'ruta INDEX de products' do
    expect(get: 'v1/products').to route_to(
      format: 'json',
      controller: 'v1/products',
      action: 'index'
    )
  end

  it 'ruta DESTROY de productos' do
    expect(delete: 'v1/products/1').to route_to(
      format: 'json',
      controller: 'v1/products',
      action: 'destroy',
      id: '1'
    )
  end
end
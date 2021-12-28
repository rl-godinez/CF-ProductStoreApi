require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validaciones del producto' do
    subject { build(:product) }

    it 'validar si el store_id esta presente' do
      should validate_presence_of(:store_id)
    end

    it 'validar si el name esta presente' do
      should validate_presence_of(:name)
    end

    it 'validar si el description esta presente' do
      should validate_presence_of(:description)
    end

    it 'validar si el price esta presente' do
      should validate_presence_of(:price)
    end

    it 'validar relacion con store' do
      should belong_to(:store)
    end
  end
end

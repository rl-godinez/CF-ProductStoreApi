require 'rails_helper'

RSpec.describe Store, type: :model do
  describe "validaciones al modelo" do
    subject { build(:store) }

    it 'validar si el nombre esta presente' do
      should validate_presence_of(:name)
    end

    it 'validar la relacion con un owner' do
      should have_one(:owner)
    end

    it 'validar relacion con muchos empleados' do
      should have_many(:employees)
    end

    it 'validar relacion con muchos productos' do
      should have_many(:products)
    end
  end
end

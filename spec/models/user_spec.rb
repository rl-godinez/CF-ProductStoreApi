require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validaciones del model User' do
    subject { build(:user) }

    it 'validar si email esta presente' do
      should validate_presence_of(:email)
    end

    it 'validar si type esta presente' do
      should validate_presence_of(:type)
    end

    it 'validar si age esta presente' do
      should validate_presence_of(:age)
    end

    it 'validar si password esta presente' do
      should validate_presence_of(:password_digest)
    end

    it 'validar si el correo es unico' do
      should validate_uniqueness_of(:email)
    end

    it 'validar si el email es valido' do
      should_not allow_value("test").for(:email)
    end

    it 'validar que age sea un numero entero' do
      should validate_numericality_of(:age).only_integer
    end

    it 'validar si la edad es mayor o igual a 18' do
      should validate_numericality_of(:age).is_greater_than_or_equal_to(18)
    end

    it 'validar si la edad es menor o igual a 100' do
      should validate_numericality_of(:age).is_less_than_or_equal_to(100)
    end

    it 'validar que solamente se pueden crear emplados y propierator en type' do
      should validate_inclusion_of(:type).in_array(%w[Owner Employee])
    end

    it 'validar si existe relacion un store' do
      should belong_to(:store)
    end

    it 'validar relacion con el token' do
      should have_many(:tokens)
    end
  end
end

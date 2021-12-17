require 'rails_helper'

RSpec.describe Token, type: :model do
  describe 'validaciones al modelo' do
    subject { build(:token) }

    it 'validar presencia del token' do
      should validate_presence_of(:token)
    end

    it 'validar presencia del user_id' do
      should validate_presence_of(:user_id)
    end

    it 'validar presencia del expires_at' do
      should validate_presence_of(:expires_at)
    end

    it 'validar relacion con el usuario' do
      should belong_to(:user)
    end
  end
end

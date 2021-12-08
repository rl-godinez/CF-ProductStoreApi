require 'rails_helper'

RSpec.describe Store, type: :model do
  describe "validaciones al modelo" do
    subject { build(:store) }

    it 'validar si el nombre esta presente' do
      should validate_presence_of(:name)
    end
  end
end

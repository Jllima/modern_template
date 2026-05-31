require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    # Verifica se a fábrica padrão constrói um produto válido
    it 'has a valid factory' do
      expect(build(:product)).to be_valid
    end

    # Validações de Presença (Presence)
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:price) }

    # Validação Numérica (Numericality)
    it { is_expected.to validate_numericality_of(:price).is_greater_than(0) }
  end
end

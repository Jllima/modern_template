# frozen_string_literal: true

require "rails_helper"

RSpec.describe Post, type: :model do
  describe "validações estruturais (shoulda-matchers)" do
    # Garante que não é possível salvar no banco sem esses campos
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:desc) }
  end

  describe "comportamento da instância" do
    context "quando todos os atributos são preenchidos corretamente" do
      it "é considerado válido" do
        post = described_class.new(
          title: "A Ascensão do Clean Code",
          desc: "Como manter a saúde do seu software a longo prazo."
        )
        
        expect(post).to be_valid
      end
    end

    context "quando faltam atributos obrigatórios" do
      it "é considerado inválido sem título" do
        post = described_class.new(
          title: nil,
          desc: "Descrição válida"
        )
        
        expect(post).not_to be_valid
        expect(post.errors[:title]).to include("can't be blank")
      end

      it "é considerado inválido sem descrição" do
        post = described_class.new(
          title: "Título Válido",
          desc: ""
        )
        
        expect(post).not_to be_valid
        expect(post.errors[:desc]).to include("can't be blank")
      end
    end
  end
end
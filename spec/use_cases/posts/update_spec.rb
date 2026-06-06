# frozen_string_literal: true

require "rails_helper"

RSpec.describe Posts::Update do
  describe ".call" do
    # Cria o registro real no banco de dados
    let!(:post) { create(:post, title: "Título Antigo") }
    
    # Gera os hashes para a simulação da atualização
    let(:valid_params) { attributes_for(:post, title: "Título Atualizado") }
    let(:invalid_params) { attributes_for(:post, title: nil) }

    context "quando os parâmetros são válidos" do
      it "atualiza o post e retorna sucesso" do
        result = described_class.call(post, valid_params)

        expect(result.success?).to be(true)
        expect(result.data.title).to eq("Título Atualizado")
        
        # Garante que salvou de fato no banco de dados
        expect(post.reload.title).to eq("Título Atualizado")
      end
    end

    context "quando os parâmetros são inválidos" do
      it "não atualiza no banco e retorna falha com erros" do
        result = described_class.call(post, invalid_params)

        expect(result.success?).to be(false)
        expect(result.data.errors[:title]).to include("can't be blank")
        
        # Garante que o banco de dados permaneceu intacto
        expect(post.reload.title).to eq("Título Antigo")
      end
    end
  end
end
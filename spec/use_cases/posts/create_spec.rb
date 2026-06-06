# frozen_string_literal: true

require "rails_helper"

RSpec.describe Posts::Create do
  describe ".call" do
    # O FactoryBot gera um Hash { title: "A Era...", desc: "Construindo..." }
    let(:valid_params) { attributes_for(:post) }
    
    # Sobrescrevemos o title para nil para forçar a falha
    let(:invalid_params) { attributes_for(:post, title: nil) }

    context "quando os parâmetros são válidos" do
      it "cria o post e retorna sucesso" do
        expect {
          described_class.call(valid_params)
        }.to change(Post, :count).by(1)

        result = described_class.call(valid_params)
        
        expect(result.success?).to be(true)
        expect(result.data).to be_a(Post)
        expect(result.data.title).to eq(valid_params[:title])
      end
    end

    context "quando os parâmetros são inválidos" do
      it "não cria o post e retorna falha com a instância populada com erros" do
        expect {
          described_class.call(invalid_params)
        }.not_to change(Post, :count)

        result = described_class.call(invalid_params)
        
        expect(result.success?).to be(false)
        expect(result.data).to be_a(Post)
        expect(result.data.errors[:title]).to include("can't be blank")
      end
    end
  end
end
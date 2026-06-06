# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/posts", type: :request do
  let(:valid_attributes) { { title: "A Era do Hotwire", desc: "Tudo acontece via Turbo Streams" } }
  let(:invalid_attributes) { { title: "", desc: "Falta o título obrigatório" } }
  
  let!(:post_record) { Post.create!(title: "Post Existente", desc: "Para testes de edição") }

  describe "GET /index" do
    it "renderiza a listagem com sucesso" do
      get posts_url
      expect(response).to be_successful
      expect(response.body).to include("Post Existente")
    end
  end

  describe "GET /new" do
    it "renderiza o formulário com sucesso" do
      get new_post_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renderiza o formulário de edição com sucesso" do
      get edit_post_url(post_record)
      expect(response).to be_successful
    end
  end

  describe "POST /create (Via Turbo Stream)" do
    context "com parâmetros válidos" do
      it "cria um novo Post, retorna 200 OK e injeta a linha na tabela" do
        expect do
          post posts_url, params: { post: valid_attributes }, as: :turbo_stream
        end.to change(Post, :count).by(1)

        expect(response).to have_http_status(:ok)
        
        # Garante que o Turbo recebeu as instruções corretas de UI
        expect(response.body).to include('turbo-stream action="prepend" target="posts"')
        expect(response.body).to include('turbo-stream action="update" target="modal"')
      end
    end

    context "com parâmetros inválidos" do
      it "não cria o Post e retorna 422 para atualizar o modal com erros" do
        expect do
          post posts_url, params: { post: invalid_attributes }, as: :turbo_stream
        end.not_to change(Post, :count)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update (Via Turbo Stream)" do
    context "com parâmetros válidos" do
      let(:new_attributes) { { title: "Título Atualizado" } }

      it "atualiza o Post, retorna 200 OK e substitui a linha na tabela" do
        patch post_url(post_record), params: { post: new_attributes }, as: :turbo_stream
        post_record.reload

        expect(post_record.title).to eq("Título Atualizado")
        expect(response).to have_http_status(:ok)
        
        expect(response.body).to include("turbo-stream action=\"replace\" target=\"post_#{post_record.id}\"")
        expect(response.body).to include('turbo-stream action="update" target="modal"')
      end
    end

    context "com parâmetros inválidos" do
      it "não atualiza o Post e retorna 422" do
        patch post_url(post_record), params: { post: invalid_attributes }, as: :turbo_stream
        post_record.reload

        expect(post_record.title).to eq("Post Existente")
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy (Via Turbo Stream)" do
    it "deleta o Post e remove a linha da tabela via Turbo" do
      expect do
        delete post_url(post_record), as: :turbo_stream
      end.to change(Post, :count).by(-1)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("turbo-stream action=\"remove\" target=\"post_#{post_record.id}\"")
    end
  end
end
# 🌟 Modern Dashboard Template

Este repositório é um template moderno e premium desenvolvido com **Ruby on Rails 8.1.3**, projetado para oferecer uma interface de dashboard responsiva inspirada nos padrões estéticos do **Chakra UI**. A aplicação combina a reatividade em tempo real do **Hotwire (Turbo/Stimulus)** com a performance e flexibilidade do **Tailwind CSS v4** compilado pelo esbuild.

---

## 🏗️ Arquitetura e Stack Tecnológica

O projeto foi estruturado seguindo as melhores práticas modernas de desenvolvimento Rails, focando em simplicidade no backend (sem excesso de dependências JS pesadas) e alta interatividade no frontend.

### Estrutura do Projeto

```text
app/
├── assets/
│   └── stylesheets/
│       └── application.tailwind.css  # Ponto de entrada do Tailwind CSS v4
├── controllers/
│   ├── application_controller.rb
│   ├── dashboard_controller.rb       # Controla a página inicial (Overview)
│   └── posts_controller.rb           # CRUD reativo de Posts (Hotwire)
├── use_cases/                        # Camada estrita de Regras de Negócio e Serviços
│   ├── use_case_base.rb              # Módulo base que garante o Command Pattern e o Result Object
│   └── posts/                        # Casos de uso agrupados por domínio (nascem automaticamente)
│       ├── create.rb                 # Lógica isolada de criação (Model.new, validações, integrações)
│       └── update.rb                 # Lógica isolada de atualização
├── javascript/
│   ├── application.js                # Bootstrap JS + Import do Turbo
│   └── controllers/                  # Controladores Stimulus (Interações client-side)
│       ├── counter_controller.js     # Contador de cliques interativo
│       └── ui_controller.js          # Gerenciador global de Sidebar, Modais e Dropdowns
├── models/
│   ├── application_record.rb
│   └── post.rb                       # Modelo Post (title:string, desc:string)
├── views/
│   ├── dashboard/
│   │   └── index.html.erb            # View do Dashboard principal com métricas
│   ├── layouts/
│   │   └── application.html.erb      # Layout global da aplicação com container modal
│   ├── posts/                        # Views CRUD de Post (Turbo-adaptáveis)
│   └── shared/
│       ├── _header.html.erb          # Cabeçalho global
│       └── _sidebar.html.erb         # Menu lateral responsivo
config/
├── database.yml                      # Configuração do banco PostgreSQL
└── routes.rb                         # Mapeamento de rotas da aplicação
lib/                                  # Coração da Fábrica de Software e Automações
├── generators/
│   ├── custom_scaffold_controller/   # Sobrescreve o scaffold padrão para acionar a geração de Use Cases
│   │   └── custom_scaffold_controller_generator.rb
│   └── use_case/                     # O nosso gerador inteligente que cria a lógica condicional (Create/Update)
│       ├── use_case_generator.rb
│       └── templates/use_case.rb.tt
└── templates/                        # Templates base que o Rails usa ao rodar `rails generate`
    ├── erb/scaffold/                 # Views Tailwind responsivas (Modal/Tela Cheia)
    │   ├── _form.html.erb.tt
    │   ├── index.html.erb.tt
    │   ├── new.html.erb.tt
    │   ├── edit.html.erb.tt
    │   ├── show.html.erb.tt
    │   └── partial.html.erb.tt
    └── rails/scaffold_controller/    # Controller template pré-configurado com Turbo Stream e Use Cases
```

*   **Runtime & Backend:** Ruby `3.3.5` e Rails `8.1.3`.
### 1. Infraestrutura & Banco de Dados (Docker + PostgreSQL)
*   **Banco de Dados:** PostgreSQL `16.3` rodando via Docker na porta `5435`.
* **Isolamento de Porta:** Configurámos o PostgreSQL via Docker Compose para expor a porta externa `5435` (mapeada para a `5432` interna do contêiner), evitando conflitos com outras instâncias locais do banco de dados.
* **Segurança e Variáveis:** Centralizámos as credenciais de acesso no arquivo `.env` alimentando dinamicamente o `config/database.yml` com o auxílio da gem `dotenv-rails`.

### 2. Estilização e Pipeline de Assets & JavaScript (Yarn + Esbuild)
*   **CSS / Estilização:** Tailwind CSS `v4.3.0` via `@tailwindcss/cli`.
    *   *Tema Chakra UI:* Cores personalizadas (paletas `chakra-gray`, `chakra-brand/teal` e `chakra-accent/blue`), sombras e cantos arredondados estendidos no arquivo [tailwind.config.js](file:///home/dev/workspace/ruby_3_3_5/modern_template/tailwind.config.js).
*   **JavaScript & Reatividade:**
    *   **esbuild** para empacotamento rápido de módulos JS.
    *   **Hotwire (Turbo Drive, Turbo Frames, Turbo Streams)** para atualizações assíncronas parciais e experiência Single Page Application (SPA).
    *   **StimulusJS** para gerenciamento de estados dinâmicos locais da interface do usuário (ex: modais, sidebars e contadores).
### 3. Testes Automatizados & TDD Elegante

*   **Suíte de Testes:** RSpec (`rspec-rails`) integrado com FactoryBot e SimpleCov para relatórios de cobertura de testes.
* **Shoulda Matchers:** Substituímos blocos repetitivos de asserções RSpec por declarações declarativas de uma única linha (`it { is_expected.to validate_presence_of(:name) }`), elevando a legibilidade dos testes de modelo.
* **WSL Integration:** Configurámos a interoperabilidade de relatórios com o utilitário `wslview` (`export BROWSER=wslview`), permitindo que as análises de cobertura de testes geradas pelo `SimpleCov` dentro do ecossistema Linux/WSL abram nativamente no navegador do Windows.

### 3. Engenharia de Scaffolds Customizados (`lib/templates`)
A maior evolução do projeto foi a customização dos geradores nativos do Rails para que a fábrica de software crie telas reativas instantaneamente.

* **Lixo Eliminado:** Desativámos a geração automática de CSS por modelo, Jbuilder (JSON) e Helpers vazios no `config/application.rb`.
* **Views Híbridas Dinâmicas (`erb`):** Os arquivos `new.html.erb` e `edit.html.erb` utilizam o helper `turbo_frame_request?` para se auto-adaptarem. Se forem requisitados de forma tradicional, renderizam uma página inteira com botões de voltar. Se forem chamados por links Turbo, renderizam o componente flutuante de Modal com overlay escuro (`bg-slate-900/50`) e desfoque de fundo (`backdrop-blur-sm`).
* **Controllers Reativos (`scaffold_controller`):** Reescrevemos a lógica do ciclo de vida HTTP do Rails. Ao salvar um recurso com sucesso via modal, o controller responde imediatamente com `format.turbo_stream`, injetando a nova linha (`turbo_stream.prepend` ou `turbo_stream.replace`) na tabela do Dashboard e destruindo o modal da memória (`turbo_stream.update("modal", "")`), mantendo o utilizador no mesmo contexto de navegação.

### 6. Use Cases (Service Objects)
Para evitar *Fat Models* e *Fat Controllers*, implementámos uma camada estrita de regras de negócio isolada baseada no **Command Pattern**.
* **Módulo Base (`UseCaseBase`):** Todos os serviços implementam um único método público (`call`) e retornam um **Result Object** padronizado (`success?`, `data`, `error`), garantindo respostas previsíveis.
* **Automação de Geradores:** Substituímos o gerador padrão de scaffold do Rails por um híbrido (`CustomScaffoldControllerGenerator`). Ao executar um scaffold, o Rails agora gera automaticamente os arquivos de Use Case (`Create` e `Update`) pré-preenchidos com a lógica de persistência e acoplados ao Controller Reativo.

---

## 🛠️ Atividades Realizadas até o Momento

Durante o ciclo de desenvolvimento, as seguintes atividades foram concluídas com sucesso:

1.  **Configuração Inicial & QA:** Integração e parametrização do **RSpec** como framework de testes e adição de ferramentas de auditoria de qualidade/segurança (**RuboCop**, **Brakeman**, **RubyCritic**, **SimpleCov**).
2.  **Ajuste de Geradores:** Customização dos geradores de código do Rails para criação padronizada de controllers e views.
3.  **Configuração do Banco de Dados:** Criação do ambiente conteinerizado via Docker Compose utilizando PostgreSQL rodando sob a porta `5435` mapeada localmente, bem como suas respectivas credenciais no arquivo `.env`.
4.  **Remoção de Entidades Legadas:** Limpeza estrutural removendo a tabela `customers` e o scaffold antigo de `products` para manter o escopo limpo.
5.  **Criação do Dashboard Principal:** Desenvolvimento da página inicial (`DashboardController#index`) com indicadores visuais de métricas, tabela de usuários recentes com design moderno e componentes interativos.
6.  **Implementação do CRUD de Posts:** Geração do scaffold completo para o modelo de `Post` (`title:string`, `desc:string`) e integração total com atualizações dinâmicas reativas.

---

## 🔄 Fluxo de Funcionamento e Interatividade

### 1. Reatividade com Hotwire e Turbo Streams (CRUD de Posts)
O CRUD de Posts funciona de forma totalmente reativa sem necessidade de recarregamento da página (Single Page Application feel):
*   **Abertura do Formulário (Modal):** Ao clicar em "New Post" no índice de posts, o link possui a diretiva `data-turbo-frame="modal"`. O Rails intercepta o clique, faz uma requisição HTTP assíncrona ao controller e retorna a view [new.html.erb](file:///home/dev/workspace/ruby_3_3_5/modern_template/app/views/posts/new.html.erb) encapsulada pelo helper `turbo_frame_tag "modal"`.
*   **Processamento no Servidor:** O Rails detecta que a requisição é um `turbo_frame_request?` e renderiza a janela do modal sobre o layout principal.
*   **Criação Reativa:** Ao submeter o formulário de forma bem-sucedida, o controller responde com `format.turbo_stream` executando duas operações no DOM do navegador:
    1.  Prepend do novo post renderizado pelo partial `posts/_post` na tabela de posts (`id="posts"`).
    2.  Fechamento do modal ao limpar o conteúdo do `turbo_frame_tag "modal"`.
*   **Atualização e Exclusão:** Seguem o mesmo fluxo reativo via Turbo Streams (atualizando a linha específica do post no DOM ou removendo-a após a confirmação de exclusão).

### 2. Controle de Interface Local (Stimulus Controllers)
*   **`ui_controller.js`:** Gerencia de forma reativa a visibilidade dos menus dropdown, a abertura/fechamento manual de modais (como o de suporte técnico) e a expansão/retração da Sidebar lateral tanto em telas desktop quanto no modo móvel (mobile responsive).
*   **`counter_controller.js`:** Gerencia o estado de um contador dinâmico e reativo localmente no cliente (Decrement/Increment) sem realizar nenhuma requisição ao servidor.

---

## 🚀 Como Rodar a Aplicação

Siga o passo a passo abaixo para rodar o ambiente de desenvolvimento localmente:

### Pré-requisitos
Certifique-se de ter instalado em sua máquina:
*   Ruby `3.3.5`
*   Rails `8.1.3`
*   Node.js (versão recente) & Yarn
*   Docker & Docker Compose

### 1. Configurar as Variáveis de Ambiente
Crie um arquivo `.env` na raiz do projeto com as definições do banco mapeado no Docker:

```env
DATABASE_URL=postgres://postgres:password@localhost:5435/modern_template_development
DB_HOST=localhost
DB_PORT=5435
DB_USER=postgres
DB_PASS=password
RAILS_ENV=development
export BROWSER=wslview

### 1. Iniciar o Banco de Dados (PostgreSQL)
Inicie o container do PostgreSQL em segundo plano:
```bash
docker compose up -d
```
> [!NOTE]
> O banco de dados estará rodando localmente na porta **5435**, configurado de acordo com o arquivo `.env`.

### 2. Instalar as Dependências do Projeto
Rode o bundle para as gems do Ruby e o yarn para os pacotes JS:
```bash
bundle install
yarn install
```

### 3. Preparar o Banco de Dados
Crie os bancos de dados de desenvolvimento e testes, e execute as migrações necessárias:
```bash
bin/rails db:prepare
```

### 4. Iniciar o Servidor de Desenvolvimento
Inicie a aplicação utilizando o script de inicialização `bin/dev`. Esse script utiliza o `foreman` para iniciar concorrentemente o servidor web Rails, o watcher do esbuild para JavaScript e o watcher do Tailwind para CSS:
```bash
bin/dev
```
Acesse a aplicação no navegador em: **[http://localhost:3000](http://localhost:3000)**.

### 5. Rodar a Suíte de Testes
Para executar todos os testes automatizados da aplicação:
```bash
bundle exec rspec
```

---

## 🧪 Processo de Quality Assurance (QA)

O projeto conta com um script de automação de controle de qualidade localizado em [bin/qa](file:///home/dev/workspace/ruby_3_3_5/modern_template/bin/qa). Esse pipeline consolida a execução de várias ferramentas estáticas e dinâmicas de validação, abortando imediatamente (`set -e`) se qualquer problema for detectado.

### Como Executar

Para executar todo o pipeline de QA localmente:
```bash
bin/qa
```

### Etapas do Pipeline

O script realiza as seguintes operações ordenadamente:

1. **Preparação:** Garante a criação de diretórios de documentação temporários (`docs/brakeman`, `docs/coverage` e `docs/rubycritic`).
2. **🎨 Padronização de Código (RuboCop):** Valida a formatação e os padrões estéticos definidos para o ecossistema Rails.
3. **🔒 Auditoria de Segurança (Brakeman):** Executa uma varredura estática à procura de vulnerabilidades no código, gerando relatórios detalhados nos formatos Markdown e HTML.
4. **🧪 Suíte de Testes (RSpec + SimpleCov):** Roda a suíte completa de testes automatizados e valida a cobertura de código mínima estipulada de **80%**.
5. **📊 Análise Arquitetural (RubyCritic):** Gera métricas de complexidade e churn para medir a manutenibilidade do código em `app` e `lib`.
6. **📝 Geração de Relatório de Sprint:** Consolida um resumo de aprovação e cria o arquivo executivo [docs/resumo_sprint.md](file:///home/dev/workspace/ruby_3_3_5/modern_template/docs/resumo_sprint.md).
7. **🌐 Interoperabilidade Local:** Se executado sob WSL com o utilitário `wslview` instalado, abre automaticamente os relatórios HTML detalhados no navegador padrão do host.

---

## 📊 Relatórios de Qualidade e Cobertura

Os relatórios gerados pelas ferramentas de QA podem ser acessados localmente nos seguintes caminhos:
*   **Resumo de Execução:** [docs/resumo_sprint.md](file:///home/dev/workspace/ruby_3_3_5/modern_template/docs/resumo_sprint.md)
*   **Cobertura de Testes (SimpleCov):** [docs/coverage/index.html](file:///home/dev/workspace/ruby_3_3_5/modern_template/docs/coverage/index.html)
*   **Qualidade e Complexidade do Código (RubyCritic):** [docs/rubycritic/overview.html](file:///home/dev/workspace/ruby_3_3_5/modern_template/docs/rubycritic/overview.html)
*   **Segurança (Brakeman):** [docs/brakeman/seguranca.html](file:///home/dev/workspace/ruby_3_3_5/modern_template/docs/brakeman/seguranca.html) (ou formato texto em [docs/brakeman/seguranca.md](file:///home/dev/workspace/ruby_3_3_5/modern_template/docs/brakeman/seguranca.md))

## 🚀 Para Novos Projetos a Partir Deste (Setup de Boilerplate)

Este repositório foi projetado para atuar como o ponto de partida (Boilerplate) oficial da fábrica de software. Para criar um novo sistema sem carregar o histórico do Git ou o nome genérico `ModernTemplate`, siga o fluxo abaixo rigorosamente:

### 1. Clonar e Limpar o Histórico
Faça o clone do repositório para o diretório com o nome do seu novo projeto e zere o histórico de versionamento para começar um projeto limpo:
```bash
git clone git@github.com:nome_usuario/modern_template.git nome_do_novo_projeto
cd nome_do_novo_projeto
rm -rf .git && git init
# Sintaxe: bin/rename_project NomeDoProjeto nome_do_projeto
chmod +x bin/rename_project
bin/rename_project SistemaClinicas sistema_clinicas

criar o arquivo .env
docker compose down -v && docker compose up -d
bundle install && yarn install
bin/rails db:setup
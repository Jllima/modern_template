# frozen_string_literal: true

class UseCaseGenerator < Rails::Generators::Base
  source_root File.expand_path("templates", __dir__)
  argument :model_name, type: :string
  argument :action_name, type: :string

  def create_use_case_file
    @module_name = model_name.pluralize.camelize
    @model_name = model_name.singularize.camelize
    @model_singular = model_name.singularize.underscore
    @class_name = action_name.camelize
    @action_lower = action_name.downcase

    file_path = File.join(
      "app/use_cases",
      model_name.pluralize.underscore,
      "#{action_name.underscore}.rb"
    )

    template "use_case.rb.tt", file_path
  end

  # NOVO: Método que gera os testes mantendo a segurança do código original
  def create_use_case_spec_file
    spec_file_path = File.join(
      "spec/use_cases",
      model_name.pluralize.underscore,
      "#{action_name.underscore}_spec.rb"
    )

    # Invoca o template correto baseado na ação (ex: create_spec.rb.tt, update_spec.rb.tt)
    template "#{action_name.underscore}_spec.rb.tt", spec_file_path
  end
end

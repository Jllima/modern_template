# frozen_string_literal: true

class UseCaseGenerator < Rails::Generators::Base
  source_root File.expand_path("templates", __dir__)
  argument :model_name, type: :string
  argument :action_name, type: :string

  def create_use_case_file
    @module_name = model_name.pluralize.camelize
    @class_name = action_name.camelize

    file_path = File.join(
      "app/use_cases",
      model_name.pluralize.underscore,
      "#{action_name.underscore}.rb"
    )

    template "use_case.rb.tt", file_path
  end
end

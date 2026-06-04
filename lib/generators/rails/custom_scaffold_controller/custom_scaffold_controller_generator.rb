# frozen_string_literal: true

require "rails/generators/rails/scaffold_controller/scaffold_controller_generator"

module Rails
  module Generators
    class CustomScaffoldControllerGenerator < ScaffoldControllerGenerator
      source_root ScaffoldControllerGenerator.source_root

      def manage_use_cases
        klass = Rails::Generators.find_by_namespace(:use_case)
        klass.start([class_name, "Create"], behavior: behavior, destination_root: destination_root)
        klass.start([class_name, "Update"], behavior: behavior, destination_root: destination_root)
      end
    end
  end
end

# frozen_string_literal: true

module UseCaseBase
  class Result
    attr_reader :data, :error

    def initialize(success:, data: nil, error: nil)
      @success = success
      @data = data
      @error = error
    end

    def success?
      @success
    end

    def failure?
      !@success
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
    base.class_eval do
      private_class_method :new
    end
  end

  module ClassMethods
    def call(*args, **kwargs, &block)
      new(*args, **kwargs, &block).call
    end
  end

  protected

  def success(data = nil)
    Result.new(success: true, data: data)
  end

  def failure(data = nil, error = nil)
    Result.new(success: false, data: data, error: error)
  end
end

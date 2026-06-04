# frozen_string_literal: true

module Customers
  class Create
    include UseCaseBase

    def initialize(params)
      @params = params
    end

    def call
      customer = Customer.new(@params)

      if customer.save
        success(customer)
      else
        failure(customer, customer.errors.full_messages.to_sentence)
      end
    end
  end
end

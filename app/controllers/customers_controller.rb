class CustomersController < ApplicationController
  before_action :set_customer, only: %i[show edit update destroy]

  def index
    @customers = Customer.all
  end

  def show
  end

  def new
    @customer = Customer.new
  end

  def edit
  end

  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html do
          redirect_to customers_url,
                      notice: "Customer criado."
        end

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.prepend(
              "customers",
              partial: "customers/customer",
              locals: {
                customer: @customer
              }
            ),
            turbo_stream.update("modal", "")
          ]
        end
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @customer.update(customer_params)
        format.html do
          redirect_to customers_url,
                      notice: "Customer atualizado."
        end

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(
              @customer,
              partial: "customers/customer",
              locals: {
                customer: @customer
              }
            ),
            turbo_stream.update("modal", "")
          ]
        end
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @customer.destroy!

    respond_to do |format|
      format.html do
        redirect_to customers_url,
                    notice: "Customer deletado."
      end

      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(@customer)
      end
    end
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(
      :name,
      :email,
      :phone
    )
  end
end

class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
    flash[:success] = 'You have updated book successfully.'
    redirect_to admin_customer_path(@customer)
    else
    @customers = Customer.all
    render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :telephone_number, :address, :email, :is_active)
  end

end

class Public::AddressesController < ApplicationController
  def index
    @address = Address.new
    @addresses = current_customer.addresses
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
   if @address.save
    redirect_to addresses_path(@address)
   else
    @addresses = Address.all
    render :index
   end
  end

  def edit
    @address = Address.find(params[:id])
    @address.customer_id = current_customer.id
    unless @address.customer == current_customer
        redirect_to addresses_path
    end
  end

  def update
    @address = Address.find(params[:id])
    @address.customer = current_customer
    if @address.update(address_params)
      redirect_to addresses_path
    else
      @addresses = Address.all
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.customer_id = current_customer.id
    @address.destroy
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end

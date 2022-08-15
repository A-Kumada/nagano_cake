class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @total = 0
    @cart_items = current_customer.cart_items.all
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    cart_item_params[:item_id]
    @cart_item.customer_id = current_customer.id

    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]) .present?
       cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
       cart_item.amount += params[:cart_item][:amount].to_i
       cart_item.save
       redirect_to cart_items_path
    elsif @cart_item.save
          @cart_items = current_customer.cart_items.all
          render 'index'
    else
          render 'index'
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.customer_id = current_customer.id
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.customer_id = current_customer.id
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    current_customer.cart_items
    CartItem.destroy_all
    flash[:danger] = "全て削除しました!"
    redirect_to cart_items_path

  end

  private

  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount)
  end

  def correct_customer_destroy_all
    @cart_items = current_customer.cart_items
   redirect_to cart_items_path if @cart_items.nil?
  end
end

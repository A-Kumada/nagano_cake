class Admin::ItemsController < ApplicationController
before_action :authenticate_admin!

  def index
    @items = Item.all.page(params[:page])
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    @item = Item.new(item_params)
    if @item.save
    redirect_to admin_item_path(@item)
    else
    @genres = Genre.all
    @items = Item.all
    render "new"
    end
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
      if @item.update(item_params)
      flash[:success] = 'You have updated book successfully.'
      redirect_to admin_item_path(@item)
      else
      @items = Item.all
      render :edit
      end
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :image, :genre_id)
  end

end

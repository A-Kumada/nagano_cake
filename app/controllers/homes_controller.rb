class HomesController < ApplicationController
  def top
    @genres = Genre.all
    #@items = Item.all
    @items = Item.order(created_at: :desc).limit(4)
  end

  def about
  end

end

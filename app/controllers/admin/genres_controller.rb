class Admin::GenresController < ApplicationController
#before_action :authenticate_admin!

  def index
     @genre = Genre.new
     @genres = Genre.all
  end

  def show
    @genres = Genre.all
    @genre = Genre.find(params[:id])
  end

  def create
    @genre = Genre.new(genre_params)
    @genre.save
    redirect_to admin_genres_path
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to admin_genres_path
    else
      render :edit_admin
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

end

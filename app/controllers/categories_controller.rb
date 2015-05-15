class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def show
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    if @category.create
      flash[:notice] = 'Category was successfully created'
      redirect_to @category
    else
      redirect_to :new
      flash[:error] = 'Please try again!'
    end
  end

  def update
    if @category.update(category_params)
      render :show
      flash[:notice] = 'Category was successfully updated'
    else
      render :edit
      flash[:error] = 'Please try again!'
    end
  end

  def destroy
    if @category.destroy
      flash[:notice] = 'Category was successfully destroyed'
      redirect_to categories_url
    else
      redirect_to :back
      flash[:error] = 'Please try again!'
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end

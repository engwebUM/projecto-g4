class CategoriesController < ApplicationController
  before_action :set_category, only: :destroy

  def index
    @categories = Category.all
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'Category was successfully created'
    else
      flash[:error] = 'Please try again!'
    end
    redirect_to categories_url
  end

  def destroy
    @category.destroy
    flash[:notice] = 'Category was successfully destroyed'
    redirect_to categories_url
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end

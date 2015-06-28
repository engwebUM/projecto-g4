class RevenuesController < ApplicationController
  before_action :set_revenue, only: [:show, :edit, :update, :destroy]

  def index
    revenues_scope = Revenue.all
    @revenues = smart_listing_create :revenues, list_create(revenues_scope, params[:filter]), partial: 'revenues/revenue', page_sizes: [5, 7, 13, 26]
  end

  def show
  end

  def new
    @revenue = Revenue.new
    @categories = Category.all
  end

  def edit
    @categories = Category.all
  end

  def create
    @revenue = Revenue.new(revenue_params)
    create_rev_exp(@revenue)
  end

  def update
    if @revenue.update(revenue_params)
      render :show
      msg_success
    else
      render :edit
      msg_error
    end
  end

  def destroy
    if @revenue.destroy
      msg_success
      redirect_to revenues_url
    else
      redirect_to :back
      msg_error
    end
  end

  private

  def set_revenue
    @revenue = Revenue.find(params[:id])
  end

  def revenue_params
    params.require(:revenue).permit(:date, :user_id, :category_id, :description, :amount, :document)
  end
end
